import 'package:bloc/bloc.dart';
import 'package:bloc_exercise/model/alert.dart';
import 'package:equatable/equatable.dart';

part 'alert_event.dart';
part 'alert_state.dart';

const _alertLimit = 10;
const throttleDuration = Duration(milliseconds: 100);

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  //생성자 with event handler
  AlertBloc(AlertState initialState) : super(initialState) {
    on<AlertFetched>(_onAlertFetched);
  }

  // final http.Client httpClient;

  Future<void> _onAlertFetched(
      AlertFetched event, Emitter<AlertState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == AlertStatus.initial) {
        final alerts = _fetchAlerts();
        return emit(state.copyWith(
            status: AlertStatus.success, alerts: alerts, hasReachedMax: false));
      }
    } catch (_) {
      emit(state.copyWith(status: AlertStatus.failure));
    }
  }

  List<Alert> _fetchAlerts([int startIndex = 0]) {
    List<Alert> alerts = [];
    Alert alert;
    for (int i = 0; i < 10; i++) {
      alert = Alert(
          id: i,
          contentId: i,
          type: AlertType.comment,
          main: "새로운 댓글이 있어요",
          detail: "오늘 점심 맛있겠당");
      alerts.add(alert);
    }

    return alerts;
  }
}
