import '../entity/entities.dart';

abstract class SearchStockRepository {
  Future<List<StockEntity>> search(String searchText);

  Future<void> dispose();
}
