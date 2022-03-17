import 'package:flutter/material.dart';

import 'current_date.dart';

class StonksAppBar extends StatelessWidget {
  const StonksAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stonks', style: Theme.of(context).textTheme.subtitle1),
        const CurrentDate(),
      ],
    );
  }
}
