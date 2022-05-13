import 'package:dartz/dartz.dart';
import 'package:stonks/domain/repositories/search_stock_repository.dart';

import '../../core/exception_convector.dart';
import '../entity/stock_entity.dart';

class SearchStockUseCases {
  final SearchStockRepository _repository;
  final ExceptionConvector _exceptionConvector;

  SearchStockUseCases({
    required SearchStockRepository repository,
    required ExceptionConvector exceptionConvector,
  })  : _repository = repository,
        _exceptionConvector = exceptionConvector;

  Future<Either<List<StockEntity>, String>> search(String searchText) async {
    try {
      return Left(await _repository.search(searchText));
    } catch (e) {
      return Right(_exceptionConvector.convertToMessage(e as Exception));
    }
  }
}
