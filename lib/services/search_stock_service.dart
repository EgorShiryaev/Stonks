import 'dart:convert';
import 'package:stonks/errors/exceptions.dart';
import 'package:stonks/errors/network_info.dart';
import 'package:stonks/models/stock.dart';
import 'package:stonks/settings.dart';
import 'package:http/http.dart' as http;

class SearchStockService {
  final client = http.Client();
  final networkInfo = NetworkInfo();

  Future<List<Stock>> get(String query) async {
    if (await networkInfo.isConnected) {
      final response = await client.get(SETTINGS.getUrl('/search?q=$query'));
      if (response.statusCode == 200) {
        final List prefixis = json.decode(response.body)['result'];
        return prefixis.map((e) => Stock.fromSearchService(e)).toList();
      } else {
        throw ServerException();
      }
    } else {
      throw InternetConnectionException();
    }
  }
}
