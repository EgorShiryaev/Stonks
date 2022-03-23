import 'dart:developer';

import 'package:stonks/models/stock.dart';

import '../datasources/app_info_local_datasource.dart';
import '../datasources/stocks_local_datasources.dart';

class StocksRepository {
  final _stocksLocalDataSource = StocksLocalDataSources();
  final _appInfoLocalDataSource = AppInfoLocalDataSource();

  final List<Stock> _stocks = [];

  List<Stock> get stocks => _stocks;

  init() async {
    await _stocksLocalDataSource.init();
    await _appInfoLocalDataSource.init();
    if (await _appInfoLocalDataSource.getFirstRun()) {
      _addFirstRunStock();
      _appInfoLocalDataSource.setFirstRunIsFalse();
      log('First run application: add Apple, Google, Amazon, Microsoft and BitCoin Binance');
    } else {
      _stocks.addAll(_stocksLocalDataSource.get());
      log('Loaded data from localStore');
    }
  }

  _addFirstRunStock() => firstRunStocks.map((element) => add(element));

  add(Stock stock) {
    if (!_stocks.any((element) => element.prefix == stock.prefix)) {
      _stocks.add(stock);
      _stocks.sort((a, b) => a.prefix.compareTo(b.prefix));
      _stocksLocalDataSource.add(stock);
      log('Add new stock: ${stock.prefix}');
    }
  }

  update(Stock stock, String price) {
    stock.updateLastPrice(price);
    _stocksLocalDataSource.update(stock);
  }

  delete(String prefix) {
    _stocks.removeWhere((element) => element.prefix == prefix);
    _stocksLocalDataSource.delete(prefix);
    log('Delete stock: $prefix');
  }

  dispose() async {
    await _stocksLocalDataSource.dispose();
  }
}

final firstRunStocks = [
  Stock(prefix: 'AAPL', lastPrice: 0, description: 'Apple'),
  Stock(prefix: 'GOOG', lastPrice: 0, description: 'Alphabet Class C'),
  Stock(prefix: 'AMZN', lastPrice: 0, description: 'Amazon.com'),
  Stock(prefix: 'MSFT', lastPrice: 0, description: 'Microsoft Corporation'),
  Stock(
      prefix: 'BINANCE:BTCUSDT', lastPrice: 0, description: 'BitCoin Binance'),
];
