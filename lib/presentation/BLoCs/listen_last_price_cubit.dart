import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/data/models/stock_model.dart';
import 'package:stonks/services/listen_last_price_service.dart';

import '../../domain/entity/stock_entity.dart';
import 'listen_last_price_state.dart';

class ListenLastPriceCubit extends Cubit<ListenLastPriceState> {
  final ListenLastPriceService _service;
  final Connectivity _connectivity;

  ListenLastPriceCubit({
    required ListenLastPriceService service,
    required Connectivity connectivity,
  })  : _service = service,
        _connectivity = connectivity,
        super(ListenLastPriceDisconnectedState());

  void setupConnectivityListner() {
    /// В iOS статус подключения может не обновляться при изменении статуса WiFi,
    /// это известная проблема, которая затрагивает только симуляторы.
    /// Подробнее см. https://github.com/fluttercommunity/plus_plugins/issues/479
    bool serviceIsConnected = false;
    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.ethernet) {
        if (serviceIsConnected) {
          emit(ListenLastPriceConnectedState());
        } else {
          _connect();
        }
      } else if (event == ConnectivityResult.none) {
        emit(ListenLastPriceDisconnectedState());
      }
    });
    _service.connectStream.stream.listen((event) {
      serviceIsConnected = event;
    });
  }

  void _connect() async {
    emit(ListenLastPriceConnectingState());

    final result = await _service.connect();

    if (result) {
      emit(ListenLastPriceConnectedState());
      _setupServiceListener();
    }
  }

  void _setupServiceListener() {
    _service.channel.listen(_onNewEvent, onDone: () {
      _connect();
    }, onError: (e) {
      log('Server error: $e');
      _connect();
    });
  }

  void _onNewEvent(dynamic event) {
    final response = jsonDecode(event);
    if (response['type'] != 'ping') {
      emit(ListenLastPriceNewDataState(stocks: []));
      final List<StockEntity> stocks = (response['data'] as List)
          .map((json) => StockModel.fromLastPriceService(json))
          .toList();

      emit(ListenLastPriceNewDataState(stocks: stocks));
    }
  }

  void subcribePrice(String ticker) => _service.subscribe(ticker);

  void unsubcribePrice(String ticker) => _service.unsubscribe(ticker);
}
