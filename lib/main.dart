import 'package:bloc_exercise/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'app.dart';

var log = Logger(
  printer: PrettyPrinter(),
);
void main() {
  log.d('main dart start');
  BlocOverrides.runZoned(() => runApp(App()),
      blocObserver: SimpleBlocObserver());
}
