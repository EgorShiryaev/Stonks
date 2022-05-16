import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/entities.dart';
import '../../domain/usecases/usecases.dart';
import 'blocs.dart';

class FollowStockCubit extends Cubit<FollowStockState> {
  final FollowStockUseCases _useCases;

  FollowStockCubit({required FollowStockUseCases useCases})
      : _useCases = useCases,
        super(FollowStockInitialState());

  void loadFollowedStocks() async {
    emit(FollowStockLoadingState());

    final result = await _useCases.getFollowedStocks();
    emit(result.fold<FollowStockState>(
      (l) => FollowStockLoadedState(stocks: l),
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
    emit(FollowStockLoadingState());
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
