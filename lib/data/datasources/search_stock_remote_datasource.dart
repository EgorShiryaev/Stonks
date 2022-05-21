import 'dart:convert';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../domain/entity/entities.dart';
import '../../exceptions/exceptions.dart';
import '../../settings.dart';
import '../models/models.dart';
import 'datasources.dart';

class SearchStockRemoteDatasource implements SearchStockDatasource {
  final Client _client;
  final InternetConnectionChecker _checker;

  SearchStockRemoteDatasource({
    required Client client,
    required InternetConnectionChecker connectionChecker,
  })  : _client = client,
        _checker = connectionChecker;

  @override
  Future<List<StockEntity>> search(String searchText) async {
    if (await _checker.hasConnection) {
      final response =
          await _client.get(SETTINGS.getUrl('/search?q=$searchText'));

      if (response.statusCode == 200) {
        final List<dynamic> stocks = json.decode(response.body)['result'] as List<dynamic> ;
        return stocks
            .map(
              (stock) => StockModel.fromSearch(stock as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerException();
      }
    } else {
      throw InternetConnectionException();
    }
  }

  @override
  Future<void> dispose() async {
    _client.close();
  }
}
