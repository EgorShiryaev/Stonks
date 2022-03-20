import 'package:flutter/material.dart';
import 'package:stonks/models/stock.dart';
import 'package:stonks/services/prefix_service.dart';

class PrefixProvider extends ChangeNotifier {
  final _prefixService = PrefixService();
  List<Stock> _prefixes = [];
  bool _isLoading = false;

  List<Stock> get prefixes => _prefixes;
  bool get loading => _isLoading;

  search(String query) async {
    if (query.isNotEmpty) {
      _isLoading = true;
      notifyListeners();
      _prefixes = await _prefixService.get(query);
      _isLoading = false;
      notifyListeners();
      return;
    }
    clear();
  }

  clear() {
    _prefixes.clear();
    _isLoading = false;
    notifyListeners();
  }
}
