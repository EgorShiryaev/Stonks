import 'dart:convert';
import 'dart:developer';
import 'package:stonks/settings.dart';
import 'package:web_socket_channel/io.dart';

class LastPriceService {
  final  _channel =IOWebSocketChannel.connect(SETTINGS.websocketUrl);

  final _subscribeMap = <String, int>{};

  Stream get stream => _channel.stream;

  subscribe(String prefix) {
    log('Subscribe   $prefix lastPrice');
    _channel.sink.add(json.encode({'type': 'subscribe', 'symbol': prefix}));
    if (_subscribeMap.containsKey(prefix)) {
      _subscribeMap.update(prefix, (value) => value + 1);
    } else {
      _subscribeMap.addEntries({prefix: 1}.entries);
    }
    log('Subscribes: $_subscribeMap');
  }

  unsubscribe(String prefix) {
    log('Unsubscribe $prefix lastPrice');
    final nSubscribe = _subscribeMap[prefix];
    if (nSubscribe != null) {
      if (nSubscribe == 1) {
        _channel.sink
            .add(json.encode({'type': 'unsubscribe', 'symbol': prefix}));
        _subscribeMap.remove(prefix);
      } else {
        _subscribeMap.update(prefix, (value) => value - 1);
      }
    }
    log('Subscribes: $_subscribeMap');
  }

  dispose() async => await _channel.sink.close();
}
