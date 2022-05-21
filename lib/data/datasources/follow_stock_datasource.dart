import '../../domain/entity/entities.dart';

abstract class FollowStockDatasource {
  Future<void> init();

  Future<List<StockEntity>> getAll();

  Future<StockEntity?> get(String ticker);

  Future<void> add(StockEntity stock);

  Future<void> update(StockEntity stock);

  Future<void> delete(StockEntity stock);

  Future<void> dispose();
}
