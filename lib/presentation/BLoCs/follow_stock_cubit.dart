import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/domain/entity/stock_entity.dart';
import 'package:stonks/domain/usecases/follow_stock_usecases.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_state.dart';

class FollowStockCubit extends Cubit<FollowStockState> {
  final FollowStockUseCases _useCases;

  FollowStockCubit({required FollowStockUseCases useCases})
      : _useCases = useCases,
        super(FollowStockEmptyState());

  void loadFollowedStocks() async {
    emit(FollowStockLoadingState());

    final result = await _useCases.getFollowedStocks();
    emit(result.fold<FollowStockState>(
      (l) => FollowStockLoadedState(stocks: l),
      (r) => FollowStockErrorState(message: r),
    ));
  }

  void searchStocks(String searchText) async {
    emit(FollowStockLoadingState());

    final result = await _useCases.searchInFollowed(searchText);
    emit(result.fold<FollowStockState>(
      (l) => FollowStockSearchedState(stocks: l),
      (r) => FollowStockErrorState(message: r),
    ));
  }

  void addStock(StockEntity stock) async {
    final result = await _useCases.add(stock);
    emit(result.fold<FollowStockState>(
      (l) => FollowStockLoadedState(stocks: l),
      (r) => FollowStockErrorState(message: r),
    ));
  }

  void updateStockPrice(StockEntity stock) async {
    final result = await _useCases.update(stock);
    emit(result.fold<FollowStockState>(
      (l) => FollowStockLoadedState(stocks: l),
      (r) => FollowStockErrorState(message: r),
    ));
  }

  void deleteStock(StockEntity stock) async {
    final result = await _useCases.delete(stock);
    emit(result.fold<FollowStockState>(
      (l) => FollowStockLoadedState(stocks: l),
      (r) => FollowStockErrorState(message: r),
    ));
  }
}
