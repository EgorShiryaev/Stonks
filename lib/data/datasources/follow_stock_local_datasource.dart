import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:stonks/core/follow_stock_exceptions.dart';
import 'package:stonks/data/adapters/follow_stock_adapter.dart';

import '../../domain/entity/stock_entity.dart';
import '../../settings.dart';
import 'follow_stock_datasource.dart';

class FollowStockLocalDatasource implements FollowStockDatasource {
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(FollowStockAdapter());
    }

    await Hive.openBox<StockEntity>(SETTINGS.stocksLocalDataSourcesId)
        .catchError((_) => throw DatabaseException());
  }

  @override
  Future<List<StockEntity>> get() async {
    try {
      if (!Hive.isBoxOpen(SETTINGS.stocksLocalDataSourcesId)) {
        await init();
      }
      final result = Hive.box<StockEntity>(SETTINGS.stocksLocalDataSourcesId)
          .values
          .toList();
      return result;
    } catch (e) {
      log(e.toString());
      throw LoadFollowedStocksException();
    }
  }

  @override
  void add(StockEntity stock) {
    try {
      Hive.box<StockEntity>(SETTINGS.stocksLocalDataSourcesId)
          .put(stock.ticker, stock);
    } catch (e) {
      throw AddStockException(ticker: stock.ticker);
    }
  }

  @override
  void update(StockEntity stock) {
    try {
      Hive.box<StockEntity>(SETTINGS.stocksLocalDataSourcesId)
          .put(stock.ticker, stock);
    } catch (e) {
      throw UpdateStockPriceException(ticker: stock.ticker);
    }
  }

  @override
  void delete(StockEntity stock) {
    try {
      Hive.box<StockEntity>(SETTINGS.stocksLocalDataSourcesId)
          .delete(stock.ticker);
    } catch (e) {
      throw DeleteStockException(ticker: stock.ticker);
    }
  }

  Future<void> dispose() async {
    try {
      await Hive.box<StockEntity>(SETTINGS.stocksLocalDataSourcesId).close();
    } catch (e) {
      throw DatabaseException();
    }
  }
}
