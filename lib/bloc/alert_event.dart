part of 'alert_bloc.dart';

abstract class AlertEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AlertFetched extends AlertEvent {}
