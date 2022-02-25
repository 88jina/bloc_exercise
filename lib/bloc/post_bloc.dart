import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:stream_transform/stream_transform.dart';

import '../model/post.dart';

part 'post_event.dart';
part 'post_state.dart';

var log = Logger(
  printer: PrettyPrinter(),
);
const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({required this.httpClient}) : super(const PostState()) {
    log.d("POSTBLOC CONSTRUCTOR STARTED ");
    on<PostFetched>(_onPostFetched,
        transformer: throttleDroppable(throttleDuration));
    log.d("POSTBLOC CONSTRUCTOR END ");
  }

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) =>
        droppable<E>().call(events.throttle(duration), mapper);
  }

  Future<void> _onPostFetched(
      PostFetched event, Emitter<PostState> emit) async {
    log.d("_onPostFetched function started");
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
    log.d("_onPostFetched function ended");
  }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    log.d("_fetchPosts function started");
    final response = await httpClient.get(Uri.https(
      'jsonplaceholder.typicode.com',
      '/posts',
      <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
    ));
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;

      return body.map((dynamic json) {
        return Post(
          id: json['id'] as int,
          title: json['title'] as String,
          body: json['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
