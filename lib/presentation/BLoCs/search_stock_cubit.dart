import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/usecases.dart';
import 'blocs.dart';

class SearchStockCubit extends Cubit<SearchStockState> {
  final SearchStockUseCases _useCases;

  // Необхожимо для отображения последнего запроса
  int _nRequestSendedNow = 0;
  // Необхожимо для того чтобы при очистке поиска не отображался последний запрос
  bool _stopSearching = false;

  SearchStockCubit({required SearchStockUseCases useCases})
      : _useCases = useCases,
        super(SearchStockInitialState());

  void searchStocks(String searchText) async {
    emit(SearchStockLoadingState());

    _nRequestSendedNow++;
    _stopSearching = false;
    final result = await _useCases.search(searchText);
    _nRequestSendedNow--;
    if (_nRequestSendedNow == 0 && !_stopSearching) {
      emit(result.fold<SearchStockState>(
        (l) => SearchStockLoadedState(stocks: l, query: searchText),
        (r) => SearchStockErrorState(message: r),
      ));
    }
  }

  void stopSearching() {
    _stopSearching = true;
    emit(SearchStockInitialState());
  }

  Future<void> dispose() async{
    await _useCases.dispose();
  }
}
