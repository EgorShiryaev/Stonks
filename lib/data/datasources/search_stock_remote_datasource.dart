import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:stonks/data/datasources/search_stock_datasource.dart';
import 'package:stonks/data/models/stock_model.dart';
import 'package:stonks/domain/entity/stock_entity.dart';

import '../../core/search_stock_exceptions.dart';
import '../../settings.dart';

class SearchStockRemoteDatasource implements SearchStockDatasource {
  final Client _client;
  final Connectivity _connectivity;

  SearchStockRemoteDatasource({
    required Client client,
    required Connectivity connectivity,
  })  : _client = client,
        _connectivity = connectivity;

  @override
  Future<List<StockEntity>> search(String searchText) async {
    if (await _connectivity.checkConnectivity() ==
        ConnectivityResult.ethernet) {
      final response =
          await _client.get(SETTINGS.getUrl('/search?q=$searchText'));
          
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> stocks =
            json.decode(response.body)['result'];
        return stocks.map((stock) => StockModel.fromSearch(stock),).toList();
      } else {
        throw ServerException();
      }
    } else {
      throw InternetConnectionException();
    }
  }
}
