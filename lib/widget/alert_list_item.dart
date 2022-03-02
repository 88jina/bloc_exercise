import 'package:bloc_exercise/model/alert.dart';
import 'package:flutter/material.dart';

class AlertListItem extends StatelessWidget {
  final Alert alert;

  const AlertListItem({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: const Icon(
        Icons.comment,
        color: Colors.grey,
        size: 20.0,
        textDirection: TextDirection.ltr,
      ),
      title: Text(alert.main),
      isThreeLine: true,
      subtitle: Text(alert.detail),
      dense: true,
    );
  }
}
