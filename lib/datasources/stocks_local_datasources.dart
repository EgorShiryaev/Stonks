import 'package:hive_flutter/hive_flutter.dart';
import 'package:stonks/settings.dart';
import '../models/stock.dart';

class StocksLocalDataSources {
  init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(StockAdapter());
    }
    await Hive.openBox<Stock>(SETTINGS.stocksLocalDataSourcesUrl);
  }

  List<Stock> get() =>
      Hive.box<Stock>(SETTINGS.stocksLocalDataSourcesUrl).values.toList();

  void add(Stock stock) => Hive.box<Stock>(SETTINGS.stocksLocalDataSourcesUrl)
      .put(stock.prefix, stock);

  void update(Stock stock) =>
      Hive.box<Stock>(SETTINGS.stocksLocalDataSourcesUrl)
          .put(stock.prefix, stock);

  void delete(String prefix) =>
      Hive.box<Stock>(SETTINGS.stocksLocalDataSourcesUrl).delete(prefix);

  dispose() async =>
      await Hive.box<Stock>(SETTINGS.stocksLocalDataSourcesUrl).close();
}
