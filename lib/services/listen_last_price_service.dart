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

  final _subscribeMap = <String, int>{};

  String _getSubscribeJson(bool isSubscribe, String symbol) => json.encode(
      {'type': isSubscribe ? 'subscribe' : 'unsubscribe', 'symbol': symbol});

  subscribe(String ticker) {
    channel.add(_getSubscribeJson(true, ticker));

    if (_subscribeMap.containsKey(ticker)) {
      _subscribeMap.update(ticker, (value) => value + 1);
    } else {
      _subscribeMap.addEntries({ticker: 1}.entries);
    }

    log('Subscribes: $_subscribeMap');
  }

  unsubscribe(String ticker) {
    final nSubscribe = _subscribeMap[ticker];
    if (nSubscribe != null) {
      if (nSubscribe == 1) {
        channel.add(_getSubscribeJson(false, ticker));
        _subscribeMap.remove(ticker);
      } else {
        _subscribeMap.update(ticker, (value) => value - 1);
      }
    }
    log('Subscribes: $_subscribeMap');
  }

  dispose() async => await channel.close();
}
