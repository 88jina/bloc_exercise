part of 'alert_bloc.dart';

enum AlertStatus { initial, success, failure }

class AlertState extends Equatable {
  final AlertStatus status;
  final List<Alert> alerts;
  final bool hasReachedMax;

  const AlertState(
      {this.status = AlertStatus.initial,
      this.alerts = const <Alert>[],
      this.hasReachedMax = false});

  AlertState copyWith(
      {AlertStatus? status, List<Alert>? alerts, bool? hasReachedMax}) {
    // TODO: implement copyWith
    return AlertState(
        status: status ?? this.status,
        alerts: alerts ?? this.alerts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return 'AlertState{status: $status, alerts: $alerts, hasReachedMax: $hasReachedMax}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, alerts, hasReachedMax];
}
