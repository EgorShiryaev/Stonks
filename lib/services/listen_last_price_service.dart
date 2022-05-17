import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import '../settings.dart';

class ListenLastPriceService {
  late WebSocket channel;

  bool _isConnect = false;
  bool get isConnect => _isConnect;

  Future<bool> connect() async {
    log("connecting...");
    try {
      if (!_isConnect) {
        channel = await WebSocket.connect(SETTINGS.websocketUrl);
        _isConnect = true;
      }
      log("connected");
      return true;
    } catch (e) {
      _isConnect = false;
      log("Error! can not connect WS " + e.toString());
      return false;
    }
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

  subscribe(String ticker) {
    channel.add(_getSinkJson(isSubscribe: true, symbol: ticker));
    _subscribes.add(ticker);
    log('Subscribes: $_subscribes');
  }

  unsubscribe(String ticker) {
    channel.add(_getSinkJson(isSubscribe: false, symbol: ticker));
    _subscribes.remove(ticker);
    log('Subscribes: $_subscribes');
  }

  dispose() async => await channel.close();
}
