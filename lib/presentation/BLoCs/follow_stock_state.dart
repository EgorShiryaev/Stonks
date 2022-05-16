import 'package:stonks/domain/entity/stock_entity.dart';

abstract class FollowStockState {}

class FollowStockInitialState extends FollowStockState {}

class FollowStockLoadingState extends FollowStockState {}

class FollowStockLoadedState extends FollowStockState {
  final List<StockEntity> stocks;

  FollowStockLoadedState({required this.stocks});
}

class FollowStockErrorState extends FollowStockState {
  final String message;

  FollowStockErrorState({required this.message});
}
