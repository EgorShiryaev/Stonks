import 'package:stonks/data/datasources/follow_stock_datasource.dart';
import 'package:stonks/domain/entity/stock_entity.dart';
import 'package:stonks/domain/repositories/follow_stock_repository.dart';

class FollowStockRepositoryImpl implements FollowStockRepository {
  final FollowStockDatasource _datasource;

  FollowStockRepositoryImpl({required FollowStockDatasource datasource})
      : _datasource = datasource;

  @override
  Future<List<StockEntity>> get followedStocks async => _datasource.get();

  @override
  Future<List<StockEntity>> search(String searchText) async =>
      await followedStocks.then((stocks) => stocks
          .where((element) =>
              element.ticker.contains(searchText) ||
              element.title.contains(searchText))
          .toList());

  @override
  void add(StockEntity stock) => _datasource.add(stock);

  @override
  void delete(StockEntity stock) => _datasource.delete(stock);

  @override
  void update(StockEntity stock) => _datasource.update(stock);
}
