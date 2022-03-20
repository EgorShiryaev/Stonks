import 'package:hive_flutter/hive_flutter.dart';
import '../models/stock.dart';

class StocksLocalDataSources {
  final _url = 'box_for_stocks';

  init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(StockAdapter());
    }
    await Hive.openBox<Stock>(_url);
  }

  List<Stock> get() => Hive.box<Stock>(_url).values.toList();

  void add(Stock stock) => Hive.box<Stock>(_url).put(stock.prefix, stock);

  void update(Stock stock) => Hive.box<Stock>(_url).put(stock.prefix, stock);

  void delete(String prefix) => Hive.box<Stock>(_url).delete(prefix);

  dispose() async => await Hive.box<Stock>(_url).close();
}
