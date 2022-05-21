import '../../data/datasources/datasources.dart';
import '../entity/entities.dart';
import 'repositories.dart';

class FollowStockRepositoryImpl implements FollowStockRepository {
  final FollowStockDatasource _datasource;

  FollowStockRepositoryImpl({required FollowStockDatasource datasource})
      : _datasource = datasource;

  @override
  Future<List<StockEntity>> get followedStocks async =>
      await _datasource.getAll();

  @override
  Future<void> add(StockEntity stock) async {
    final newStock = await _datasource.get(stock.ticker);
    if (newStock == null) {
      await _datasource.add(stock);
    }
  }

  @override
  Future<void> delete(StockEntity stock) async =>
      await _datasource.delete(stock);

  @override
  Future<void> update(StockEntity stock) async {
    final newStock = await _datasource.get(stock.ticker);
    if (newStock != null) {
      newStock.updatePrice(stock.price);
      await _datasource.update(newStock);
    }
  }

  @override
  Future<void> dispose() async {
    await _datasource.dispose();
  }
}
