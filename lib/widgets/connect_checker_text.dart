import 'package:flutter/material.dart';

class ConnectCheckerText extends StatelessWidget {
  const ConnectCheckerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Проверка подключения к интернету...',
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
