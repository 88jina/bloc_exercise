import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/alert_bloc.dart';
import 'alert_list.dart';

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
      ),
      body: BlocProvider(
        create: (_) => AlertBloc(const AlertState())..add(AlertFetched()),
        child: AlertsList(),
      ),
    );
  }
}
