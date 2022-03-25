import 'package:hive_flutter/hive_flutter.dart';
import 'package:stonks/settings.dart';

class AppInfoLocalDataSource {
  init() async {
    await Hive.openBox(SETTINGS.appInfoLocalDataSourceUrl);
  }

  getFirstRun() => Hive.box(SETTINGS.appInfoLocalDataSourceUrl)
      .get('first_run', defaultValue: true);

  setFirstRunIsFalse() =>
      Hive.box(SETTINGS.appInfoLocalDataSourceUrl).put('first_run', false);
}
