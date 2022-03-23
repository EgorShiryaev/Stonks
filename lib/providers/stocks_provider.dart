import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:stonks/errors/exceptions.dart';
import 'package:stonks/repositories/stocks_repository.dart';
import 'package:stonks/services/search_stock_service.dart';
import '../models/stock.dart';
import '../services/last_price_service.dart';

class StocksProvider extends ChangeNotifier {
  final _repository = StocksRepository();
  final _lastPriceService = LastPriceService();
  final _searchStockService = SearchStockService();

  int _nQuery = 0;

  // идет ли загрузка из локального хранилища
  bool _loadingSavedStocks = true;
  bool get loadingSavedStocks => _loadingSavedStocks;

  // идет ли загрузка данных через запрос поиска
  bool _loadingSearchedStocks = false;
  bool get loadingSearchedStocks => _loadingSearchedStocks;

  // производится ли в данный момент поиск
  bool _searching = false;
  bool get searching => _searching;

  // данные сохраненные в листе отслеживания
  List<Stock> _savedStocks = [];
  List<Stock> get savedStocks => _savedStocks;

  // найденные по запросу поиска данные
  List<Stock> _searchedStocks = [];
  List<Stock> get searchedStocks => _searchedStocks;

  // последние слова поиска
  String _lastQuery = '';
  String get lastQuery => _lastQuery;

  // происходит ли фильтрация сохраненных в листе отслеживания
  // данных с помощью поисковой строке
  bool _savesStoksIsFiltered = false;
  bool get savesStoksIsFiltered => _savesStoksIsFiltered;

  // флаг ошибки подключения к интернету
  bool _errorIsInternetConnection = false;
  bool get errorIsConnectNetwork => _errorIsInternetConnection;

  // флаг ошибки сервера
  bool _errorIsServerFailure = false;
  bool get errorIsServerFailure => _errorIsServerFailure;

  void init() async {
    await _repository.init();
    _savedStocks = _repository.stocks;
    _loadingSavedStocks = false;
    notifyListeners();
    _setListnerToNewPrices();
  }

  void add(Stock stock) {
    _savedStocks.add(stock);
    _repository.add(stock);
    _savedStocks.sort((a, b) => a.prefix.compareTo(b.prefix));
    notifyListeners();
  }

  void delete(String prefix) {
    _repository.delete(prefix);
    _savedStocks.removeWhere((element) => element.prefix == prefix);
    notifyListeners();
  }

  void searchStock(String query) async {
    try {
      if (query.isNotEmpty) {
        _errorIsServerFailure = false;
        _errorIsInternetConnection = false;
        _nQuery++;
        _loadingSearchedStocks = true;
        _searching = true;
        notifyListeners();
        _searchedStocks = await _searchStockService.get(query);
        _loadingSearchedStocks = false;
        _nQuery--;
        if (!searching) {
          _searchedStocks.clear();
        }
        if (_nQuery == 0) {
          _lastQuery = query;
          notifyListeners();
        }
      }
    } on InternetConnectionException {
      _loadingSearchedStocks = false;
      _errorIsInternetConnection = true;
      notifyListeners();
    } catch (e) {
      log('error: $e');
      _loadingSearchedStocks = false;
      _errorIsServerFailure = true;
      notifyListeners();
    }
  }

  void _setListnerToNewPrices() {
    _lastPriceService.stream.listen((event) {
      bool priceIsChange = false;
      final List? data = json.decode(event)['data'];
      if (data == null) {
        return;
      }
      for (var stock in savedStocks) {
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
      }
      if (priceIsChange) {
        notifyListeners();
      }
    });
  }

  void deleteSearchedStocks() {
    _searchedStocks.clear();
    _searching = false;
    _savedStocks = _repository.stocks;
    _lastQuery = '';
    _savesStoksIsFiltered = false;
    notifyListeners();
  }

  void searchInSavedStocks(String text) {
    final lowercaseSearchText = text.toLowerCase();
    _savesStoksIsFiltered = true;
    _savedStocks = _repository.stocks
        .where((element) =>
            element.prefix.toLowerCase().contains(lowercaseSearchText) ||
            element.description.toLowerCase().contains(lowercaseSearchText))
        .toList();
    notifyListeners();
  }

  subscribeToLastPrice(String prefix) => _lastPriceService.subscribe(prefix);

  unsubscribeToLastPrice(String prefix) =>
      _lastPriceService.unsubscribe(prefix);

  @override
  void dispose() async {
    await _lastPriceService.dispose();
    await _repository.dispose();
    super.dispose();
  }
}
