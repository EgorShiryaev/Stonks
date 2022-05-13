import '../../domain/entity/stock_entity.dart';

abstract class SearchStockState {}

class SearchStockEmptyState extends SearchStockState {}

class SearchStockLoadingState extends SearchStockState {}

class SearchStockLoadedState extends SearchStockState {
  final List<StockEntity> stocks;

  SearchStockLoadedState({required this.stocks});
}

class SearchStockErrorState extends SearchStockState {
  final String message;

  SearchStockErrorState({required this.message});
}
