import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDate extends StatefulWidget {
  const CurrentDate({Key? key}) : super(key: key);

  @override
  State<CurrentDate> createState() => _CurrentDateState();
}

class _CurrentDateState extends State<CurrentDate> {
  DateTime dateNow = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'ru';
  }

  setTimer() {
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
    setTimer();
    return Text(
      DateFormat.yMMMMd().format(dateNow),
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
