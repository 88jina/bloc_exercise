import 'package:equatable/equatable.dart';

enum AlertType { keyword, service, menu, comment }

class Alert extends Equatable {
  final int id;
  final int contentId;
  final AlertType type;
  final String main;
  final String detail;

  const Alert(
      {required this.id,
      required this.contentId,
      required this.type,
      required this.main,
      required this.detail});

  @override
  List<Object?> get props => [id, type, contentId, main, detail];
}
