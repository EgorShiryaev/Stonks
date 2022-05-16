import '../entity/entities.dart';

abstract class FollowStockRepository {
  Future<List<StockEntity>> get followedStocks;

  void add(StockEntity stock);

  void update(StockEntity stock);

  void delete(StockEntity stock);
}
