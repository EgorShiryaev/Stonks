import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/entities.dart';
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

  StreamSubscription<List<StockEntity>>? _listner;

  void setupConnectivityListner() {
    _connectionChecker.connectionStream.listen((event) {
      if (event) {
        _connect();
      } else {
        _service.clearSubscribeArray();
        emit(ListenLastPriceDisconnectedState());
      }
    });
  }

  void _connect() async {
    emit(ListenLastPriceConnectingState());

    final result = await _service.connect();

    if (result) {
      emit(ListenLastPriceConnectedState());
      if (_listner == null) {
        _setupServiceListener();
      }
    }
  }

  void _setupServiceListener() {
    _listner = _service.lastPriceStream.listen((event) {
      emit(ListenLastPriceNewDataState(stocks: event));
    });
  }

  void subcribePrice(String ticker) => _service.subscribeToStockPrice(ticker);

  void unsubcribePrice(String ticker) =>
      _service.unsubscribeToStockPrice(ticker);

  Future<void> dispose() async {
    if (_listner != null) {
      await _listner!.cancel();
    }
    await _service.dispose();
    await _connectionChecker.dispose();
  }
}
