import 'package:stonks/domain/entity/stock_entity.dart';

abstract class SearchStockRepository {
  Future<List<StockEntity>> search(String searchText);
}
