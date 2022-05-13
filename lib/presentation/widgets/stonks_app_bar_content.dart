import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StonksAppBarContent extends StatefulWidget {
  const StonksAppBarContent({Key? key}) : super(key: key);

  @override
  State<StonksAppBarContent> createState() => _StonksAppBarContentState();
}

class _StonksAppBarContentState extends State<StonksAppBarContent> {
  DateTime dateNow = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'ru';
  }

  @override
  void didUpdateWidget(covariant StonksAppBarContent oldWidget) {
    setTimer();
    super.didUpdateWidget(oldWidget);
  }

  void setTimer() {
    final durationToNextDayInSeconds = DateTime(
      dateNow.year,
      dateNow.month,
      dateNow.day,
    ).add(const Duration(days: 1)).difference(dateNow);
    timer = Timer(durationToNextDayInSeconds, () {
      setState(() => dateNow = DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stonks', style: Theme.of(context).textTheme.subtitle1),
        Text(
          DateFormat.yMMMMd().format(dateNow),
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
