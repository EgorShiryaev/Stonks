import '../../data/datasources/datasources.dart';
import '../entity/entities.dart';
import 'repositories.dart';

class SearchStockRepositoryImpl implements SearchStockRepository {
  final SearchStockDatasource _datasource;

  SearchStockRepositoryImpl({required SearchStockDatasource datasource})
      : _datasource = datasource;

  @override
  Future<List<StockEntity>> search(String searchText) {
    return _datasource.search(searchText);
  }
}
