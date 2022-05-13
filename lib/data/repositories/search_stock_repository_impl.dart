import 'package:stonks/data/datasources/search_stock_datasource.dart';
import 'package:stonks/domain/entity/stock_entity.dart';
import 'package:stonks/domain/repositories/search_stock_repository.dart';

class SearchStockRepositoryImpl implements SearchStockRepository {
  final SearchStockDatasource _datasource;

  SearchStockRepositoryImpl({required SearchStockDatasource datasource})
      : _datasource = datasource;

  @override
  Future<List<StockEntity>> search(String searchText) {
    return _datasource.search(searchText);
  }
}
