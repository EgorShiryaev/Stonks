import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentDateView extends StatefulWidget {
  const CurrentDateView({Key? key}) : super(key: key);

  @override
  State<CurrentDateView> createState() => _CurrentDateViewState();
}

class _CurrentDateViewState extends State<CurrentDateView> {
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
