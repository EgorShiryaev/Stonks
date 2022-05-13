import '../../domain/entity/stock_entity.dart';

abstract class SearchStockDatasource {
  Future<List<StockEntity>> search(String searchText);
}
