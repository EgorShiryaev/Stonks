import '../../domain/entity/entities.dart';

abstract class SearchStockDatasource {
  Future<List<StockEntity>> search(String searchText);
}
