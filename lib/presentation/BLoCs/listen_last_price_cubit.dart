import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stonks/data/models/stock_model.dart';
import 'package:stonks/services/listen_last_price_service.dart';

import '../../domain/entity/stock_entity.dart';
import 'listen_last_price_state.dart';

class ListenLastPriceCubit extends Cubit<ListenLastPriceState> {
  final ListenLastPriceService _service;
  final InternetConnectionChecker _internetConnectionChecker;

  ListenLastPriceCubit({
    required ListenLastPriceService service,
    required InternetConnectionChecker internetConnectionChecker,
  })  : _service = service,
        _internetConnectionChecker = internetConnectionChecker,
        super(ListenLastPriceDisconnectedState());

  bool _serviceIsConnected = false;
  bool get serviceIsConnected => _serviceIsConnected;

  void setupConnectivityListner() {
    _internetConnectionChecker.onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        if (_serviceIsConnected) {
          _connect();
        } else {
          emit(ListenLastPriceConnectedState());
        }
      } else {
        emit(ListenLastPriceDisconnectedState());
      }
    });
    _service.connectStream.stream.listen((event) {
      _serviceIsConnected = event;
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
