import 'package:flutter/material.dart';

class EmptySavedStocksView extends StatelessWidget {
  const EmptySavedStocksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Center(
        child: Text(
          'У вас нет отслеживаемых бумаг.\nЧтобы отслеживать бумагу необходимо найти ее по поиску и добавить.',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
