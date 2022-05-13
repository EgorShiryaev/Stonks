import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/search_stock_state.dart';

import '../../domain/usecases/search_stock_usecases.dart';

class SearchStockCubit extends Cubit<SearchStockState> {
  final SearchStockUseCases _useCases;

  SearchStockCubit({required SearchStockUseCases useCases})
      : _useCases = useCases,
        super(SearchStockEmptyState());

  void searchStocks(String searchText) async {
    emit(SearchStockLoadingState());

    final result = await _useCases.search(searchText);
    emit(result.fold<SearchStockState>(
      (l) => SearchStockLoadedState(stocks: l),
      (r) => SearchStockErrorState(message: r),
    ));
  }
}
