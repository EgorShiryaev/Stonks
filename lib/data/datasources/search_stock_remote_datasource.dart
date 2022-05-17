import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import '../../domain/entity/entities.dart';
import '../../exceptions/exceptions.dart';
import '../../settings.dart';
import '../models/models.dart';
import 'datasources.dart';

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
    final connect = await _connectivity.checkConnectivity();
    if (connect == ConnectivityResult.wifi ||
        connect == ConnectivityResult.ethernet ||
        connect == ConnectivityResult.mobile) {
      final response =
          await _client.get(SETTINGS.getUrl('/search?q=$searchText'));

      if (response.statusCode == 200) {
        final List<dynamic> stocks =
            json.decode(response.body)['result'];
        return stocks
            .map(
              (stock) => StockModel.fromSearch(stock),
            )
            .toList();
      } else {
        throw ServerException();
      }
    } else {
      throw InternetConnectionException();
    }
  }
}