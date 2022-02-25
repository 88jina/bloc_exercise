import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  var log = Logger(printer: PrettyPrinter());
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.d(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.e(error);
    super.onError(bloc, error, stackTrace);
  }
}
