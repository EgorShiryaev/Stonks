import '../../domain/entity/entities.dart';

abstract class SearchStockState {}

class SearchStockInitialState extends SearchStockState {}

class SearchStockLoadingState extends SearchStockState {}

class SearchStockLoadedState extends SearchStockState {
  final String query;
  final List<StockEntity> stocks;

  SearchStockLoadedState({required this.query, required this.stocks});
}

class SearchStockErrorState extends SearchStockState {
  final String message;

  SearchStockErrorState({required this.message});
}
