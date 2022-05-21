import '../entity/entities.dart';

abstract class FollowStockRepository {
  Future<List<StockEntity>> get followedStocks;

  Future<void> add(StockEntity stock);

  Future<void> update(StockEntity stock);

  Future<void> delete(StockEntity stock);

  Future<void> dispose();
}
