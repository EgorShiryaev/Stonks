import 'package:stonks/domain/entity/stock_entity.dart';

abstract class FollowStockDatasource {
  Future<List<StockEntity>> getAll();

  StockEntity? get(String ticker);

  void add(StockEntity stock);

  void update(StockEntity stock);

  void delete(StockEntity stock);
}
