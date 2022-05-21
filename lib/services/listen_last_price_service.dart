import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:stonks/domain/entity/entities.dart';

import '../data/models/models.dart';
import '../settings.dart';

class ListenLastPriceService {
  WebSocket? _channel;

  final StreamController<List<StockEntity>> _lastPriceStreamController =
      StreamController();

  Stream<List<StockEntity>> get lastPriceStream =>
      _lastPriceStreamController.stream;

  StreamSubscription? _webSocketListner;

  Future<bool> connect() async {
    log("connecting...");
    try {
      if (_channel != null) {
        await _channel!.close();
      }
      _channel = await WebSocket.connect(SETTINGS.websocketUrl);
      _setupWebSocketListner();
      log("connected");
      return true;
    } catch (e) {
      log("Error! can not connect WS " + e.toString());
      return false;
    }
  }

  void _setupWebSocketListner() async {
    if (_webSocketListner != null) {
      await _webSocketListner!.cancel();
    }
    _webSocketListner = _channel!.listen((dynamic event) {
      final response = jsonDecode(event);
      if (response['type'] != 'ping') {
        final List<StockEntity> stocks = (response['data'] as List)
            .map((json) => StockModel.fromLastPriceService(json))
            .toList();
        _lastPriceStreamController.add(stocks);
      }
    }, onDone: () {
      connect();
    }, onError: (e) {
      log('Server error: $e');
      connect();
    });
  }

  Future<void> dispose() async {
    await _channel!.close();
    if (_webSocketListner != null) {
      await _webSocketListner!.cancel();
    }
    await _lastPriceStreamController.close();
  }

  final _subscribes = <String>[];

  String _getSinkJson({
    required bool isSubscribe,
    required String symbol,
  }) =>
      json.encode({
        'type': isSubscribe ? 'subscribe' : 'unsubscribe',
        'symbol': symbol
      });

  void subscribeToStockPrice(String ticker) {
    _channel!.add(_getSinkJson(isSubscribe: true, symbol: ticker));
    _subscribes.add(ticker);
    log('Subscribes: $_subscribes');
  }

  void unsubscribeToStockPrice(String ticker) {
    // Необходимо, чтобы при перестройке списка не отписывалось от отображаемых акций
    if (_subscribes.where((element) => element == ticker).length == 1) {
      _channel!.add(_getSinkJson(isSubscribe: false, symbol: ticker));
    }
    _subscribes.remove(ticker);
    log('Subscribes: $_subscribes');
  }

  void clearSubscribeArray() {
    _subscribes.clear();
    log('Subscribes: $_subscribes');
  }
}
