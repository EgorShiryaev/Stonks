import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/search_stock_state.dart';

import '../../domain/usecases/search_stock_usecases.dart';

class SearchStockCubit extends Cubit<SearchStockState> {
  final SearchStockUseCases _useCases;

  int nRequestSendedNow = 0;

  SearchStockCubit({required SearchStockUseCases useCases})
      : _useCases = useCases,
        super(SearchStockInitialState());

  void searchStocks(String searchText) async {
    emit(SearchStockLoadingState());

    nRequestSendedNow++;
    final result = await _useCases.search(searchText);
    nRequestSendedNow--;
    if (nRequestSendedNow == 0) {
      emit(result.fold<SearchStockState>(
        (l) => SearchStockLoadedState(stocks: l, query: searchText),
        (r) => SearchStockErrorState(message: r),
      ));
    }
  }

  void stopSearching() {
    emit(SearchStockInitialState());
  }
}
