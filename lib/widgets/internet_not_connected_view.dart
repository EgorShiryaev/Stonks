import 'package:flutter/material.dart';

class InternetNotConnectedView extends StatelessWidget {
  final Function() onRefresh;
  const InternetNotConnectedView({Key? key, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Нет подключения к интернету. Проверьте подключение и обновите страницу',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh),
          iconSize: 50,
        )
      ],
    );
  }
}
