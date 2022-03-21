import 'dart:convert';
import 'package:stonks/models/stock.dart';
import 'package:stonks/settings.dart';
import 'package:http/http.dart' as http;

class SearchStockService {
  final client = http.Client();

  Future<List<Stock>> get(String query) async {
    final response = await client.get(SETTINGS.getUrl('/search?q=$query'));
    if (response.statusCode == 200) {
      final List prefixis = json.decode(response.body)['result'];
      return prefixis.map((e) => Stock.fromSearchService(e)).toList();
    } else {
      return [];
    }
  }
}
