import 'package:stonks/domain/entity/stock_entity.dart';

abstract class FollowStockRepository {
  Future<List<StockEntity>> get followedStocks;

  Future<List<StockEntity>> search(String searchText);

  void add(StockEntity stock);

  void update(StockEntity stock);

  void delete(StockEntity stock);
}
