import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';
import '../settings.dart';

class ListenLastPriceService {
  late WebSocket channel;

  final StreamController<bool> connectStream = StreamController()..add(false);

  Future<bool> connect() async {
    log("conecting...");
    try {
      channel = await WebSocket.connect(SETTINGS.websocketUrl);
      connectStream.sink.add(true);
      log("conected");
      return true;
    } catch (e) {
     connectStream.sink.add(false);
      log("Error! can not connect WS " + e.toString());
      return false;
    }
  }

  final _subscribeMap = <String, int>{};

  String _getSubscribeJson(bool isSubscribe, String symbol) => json.encode(
      {'type': isSubscribe ? 'subscribe' : 'unsubscribe', 'symbol': symbol});

  subscribe(String ticker) {
    log('Subscribe  $ticker lastPrice');
    channel.add(_getSubscribeJson(true, ticker));

    if (_subscribeMap.containsKey(ticker)) {
      _subscribeMap.update(ticker, (value) => value + 1);
    } else {
      _subscribeMap.addEntries({ticker: 1}.entries);
    }

    log('Subscribes: $_subscribeMap');
  }

  unsubscribe(String ticker) {
    log('Unsubscribe $ticker lastPrice');
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
