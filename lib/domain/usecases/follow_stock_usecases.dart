import 'package:dartz/dartz.dart';
import 'package:stonks/domain/repositories/follow_stock_repository.dart';

import '../../core/exception_convector.dart';
import '../entity/stock_entity.dart';

class FollowStockUseCases {
  final FollowStockRepository _repository;
  final ExceptionConvector _exceptionConvector;

  FollowStockUseCases({
    required FollowStockRepository repository,
    required ExceptionConvector exceptionConvector,
  })  : _repository = repository,
        _exceptionConvector = exceptionConvector;

  Future<Either<List<StockEntity>, String>> getFollowedStocks() async {
    try {
      return Left(await _repository.followedStocks);
    } catch (e) {
      return Right(_exceptionConvector.convertToMessage(e as Exception));
    }
  }

  Future<Either<List<StockEntity>, String>> add(StockEntity stock) async {
    try {
      _repository.add(stock);
      return Left(await _repository.followedStocks);
    } catch (e) {
      return Right(_exceptionConvector.convertToMessage(e as Exception));
    }
  }

  Future<Either<List<StockEntity>, String>> update(StockEntity stock) async {
    try {
      _repository.update(stock);
      return Left(await _repository.followedStocks);
    } catch (e) {
      return Right(_exceptionConvector.convertToMessage(e as Exception));
    }
  }

  Future<Either<List<StockEntity>, String>> delete(StockEntity stock) async {
    try {
      _repository.delete(stock);
      return Left(await _repository.followedStocks);
    } catch (e) {
      return Right(_exceptionConvector.convertToMessage(e as Exception));
    }
  }
}
