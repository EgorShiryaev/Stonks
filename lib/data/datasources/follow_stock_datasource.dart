import 'package:stonks/domain/entity/stock_entity.dart';

abstract class FollowStockDatasource {
  Future<List<StockEntity>> get();

  void add(StockEntity stock);

  void update(StockEntity stock);

  void delete(StockEntity stock);
}
