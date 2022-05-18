import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/services.dart';
import 'blocs.dart';

class ListenLastPriceCubit extends Cubit<ListenLastPriceState> {
  final ListenLastPriceService _service;
  final ConnectionCheckerService _connectionChecker;

  ListenLastPriceCubit({
    required ListenLastPriceService service,
    required ConnectionCheckerService connectionChecker,
  })  : _service = service,
        _connectionChecker = connectionChecker,
        super(ListenLastPriceDisconnectedState());

  bool _serviceListnerIsSetuped = false;

  void setupConnectivityListner() {
    _connectionChecker.connectionStream.listen((event) {
      if (event) {
        _connect();
      } else {
        _service.unsubscribeToAllStocksPrice();
        emit(ListenLastPriceDisconnectedState());
      }
    });
  }

  void _connect() async {
    emit(ListenLastPriceConnectingState());

    final result = await _service.connect();

    if (result) {
      emit(ListenLastPriceConnectedState());
      if (!_serviceListnerIsSetuped) {
        _setupServiceListener();
        _serviceListnerIsSetuped = true;
      }
    }
  }

  void _setupServiceListener() {
    _service.lastPriceStream.listen((event) {
      emit(ListenLastPriceNewDataState(stocks: event));
    });
  }

  void subcribePrice(String ticker) => _service.subscribeToStockPrice(ticker);

  void unsubcribePrice(String ticker) =>
      _service.unsubscribeToStockPrice(ticker);
}
