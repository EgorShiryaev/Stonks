import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:stonks/repositories/stocks_repository.dart';
import '../services/last_price_service.dart';

class StocksProvider extends ChangeNotifier {
  final _repository = StocksRepository();
  final _lastPriceService = LastPriceService();

  bool _isLoading = true;

  get stocks => _repository.stocks;
  get loading => _isLoading;

  void init() async {
    await _repository.init();
    _lastPriceService.init(stocks);
    _subscribeToNewPrices();
    _isLoading = false;
    notifyListeners();
  }

  void add(String prefix, String description) {
    _repository.add(prefix, description);
    notifyListeners();
  }

  void delete(String prefix) {
    _repository.delete(prefix);
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

  @override
  void dispose() async {
    await _lastPriceService.dispose();
    await _repository.dispose();
    super.dispose();
  }
}
