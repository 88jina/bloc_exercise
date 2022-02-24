import 'package:bloc_exercise/counter_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(const CounterApp()),
      blocObserver: CounterObserver());
}
