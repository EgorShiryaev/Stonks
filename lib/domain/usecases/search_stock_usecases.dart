import 'package:dartz/dartz.dart';
import '../../exceptions/exceptions.dart';
import '../entity/entities.dart';
import '../repositories/repositories.dart';

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

  Future<void> dispose() async {
    await _repository.dispose();
  }
}
