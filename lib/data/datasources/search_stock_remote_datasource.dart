import 'dart:convert';
import 'package:http/http.dart';
import '../../domain/entity/entities.dart';
import '../../exceptions/exceptions.dart';
import '../../services/services.dart';
import '../../settings.dart';
import '../models/models.dart';
import 'datasources.dart';

class SearchStockRemoteDatasource implements SearchStockDatasource {
  final Client _client;
  final ConnectionCheckerService _connectionChecker;

  SearchStockRemoteDatasource({
    required Client client,
    required ConnectionCheckerService connectionChecker,
  })  : _client = client,
        _connectionChecker = connectionChecker;

  @override
  Future<List<StockEntity>> search(String searchText) async {
    if (_connectionChecker.internetIsConnect) {
      final response =
          await _client.get(SETTINGS.getUrl('/search?q=$searchText'));

      if (response.statusCode == 200) {
        final List<dynamic> stocks = json.decode(response.body)['result'];
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
