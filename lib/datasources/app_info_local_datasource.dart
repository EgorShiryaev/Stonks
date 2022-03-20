import 'package:hive_flutter/hive_flutter.dart';

class AppInfoLocalDataSource {
  final _url = 'app_info';

  init() async {
    await Hive.openBox(_url);
  }

  getFirstRun() => Hive.box(_url).get('first_run', defaultValue: true);

  setFirstRunIsFalse() => Hive.box(_url).put('first_run', false);
}
