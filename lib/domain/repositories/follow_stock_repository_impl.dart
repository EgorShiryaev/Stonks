import '../../data/datasources/datasources.dart';
import '../entity/entities.dart';
import 'repositories.dart';

class FollowStockRepositoryImpl implements FollowStockRepository {
  final FollowStockDatasource _datasource;

  FollowStockRepositoryImpl({required FollowStockDatasource datasource})
      : _datasource = datasource;

  @override
  Future<List<StockEntity>> get followedStocks async => _datasource.getAll();

  @override
  void add(StockEntity stock) {
    final newStock = _datasource.get(stock.ticker);
    if (newStock == null) {
      _datasource.add(stock);
    }
  }

  @override
  void delete(StockEntity stock) => _datasource.delete(stock);

  @override
  void update(StockEntity stock) {
    final newStock = _datasource.get(stock.ticker);
    if (newStock != null) {
      newStock.updatePrice(stock.price);
      _datasource.update(newStock);
    }
  }
}
