import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:stonks/repositories/stocks_repository.dart';
import 'package:stonks/services/search_stock_service.dart';
import '../models/stock.dart';
import '../services/last_price_service.dart';

class StocksProvider extends ChangeNotifier {
  final _repository = StocksRepository();
  final _lastPriceService = LastPriceService();
  final _searchStockService = SearchStockService();

  bool _savedStocksIsLoading = true;
  bool _searchStocksIsLoading = false;
  bool _searching = false;
  List<Stock> _searchedStocks = [];

  bool get savedStockisLoading => _savedStocksIsLoading;
  bool get searchStocksIsLoading => _searchStocksIsLoading;
  bool get searching => _searching;
  List<Stock> get stocks => _repository.stocks;
  List<Stock> get searchedStock => _searchedStocks;

  void init() async {
    await _repository.init();
    _lastPriceService.init(stocks);
    _subscribeToNewPrices();
    _savedStocksIsLoading = false;
    notifyListeners();
  }

  void add(Stock stock) {
    if (!stocks.any((el) => el.prefix == stock.prefix)) {
      _repository.add(stock);
      _lastPriceService.subscribe(stock.prefix);
      notifyListeners();
    }
  }

  void delete(String prefix) {
    _repository.delete(prefix);
    _lastPriceService.unsubscribe(prefix);
    notifyListeners();
  }

  void _subscribeToNewPrices() {
    _lastPriceService.stream.listen((event) {
      bool priceIsChange = false;
      final List? data = json.decode(event)['data'];
      if (data == null) {
        return;
      }
      stocks.forEach((stock) {
        final element = data.firstWhere(
          (el) => el['s'] == stock.prefix,
          orElse: () => null,
        );
        if (element != null) {
          final newPrice = element['p'].toStringAsFixed(2);
          if (stock.lastPrice.toStringAsFixed(2) != newPrice) {
            priceIsChange = true;
            _repository.update(stock, newPrice);
          }
        }
      });
      if (priceIsChange) {
        notifyListeners();
      }
    });
  }

  void searchStock(String query) async {
    if (query.isNotEmpty) {
      _searching = true;
      _searchStocksIsLoading = true;
      notifyListeners();
      _searchedStocks = await _searchStockService.get(query);
      _searchStocksIsLoading = false;
      notifyListeners();
    }
  }

  void deleteSearchedStocks() {
    _searchedStocks.clear();
    _searching = false;
    notifyListeners();
  }

  @override
  void dispose() async {
    await _lastPriceService.dispose();
    await _repository.dispose();
    super.dispose();
  }
}
