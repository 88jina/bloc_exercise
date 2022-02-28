import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/alert_bloc.dart';
import '../widget/alert_list_item.dart';
import '../widget/bottom_loader.dart';

class AlertsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertBloc, AlertState>(builder: (context, state) {
      switch (state.status) {
        case AlertStatus.failure:
          return const Center(child: Text('failed to fetch posts'));
        case AlertStatus.success:
          if (state.alerts.isEmpty) {
            return const Center(child: Text('no posts'));
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.alerts.length
                  ? BottomLoader()
                  : AlertListItem(
                      alert: state.alerts[index],
                    );
            },
            itemCount: state.hasReachedMax
                ? state.alerts.length
                : state.alerts.length + 1,
            controller: _scrollController,
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<AlertBloc>().add(AlertFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
