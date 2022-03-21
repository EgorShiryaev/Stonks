import 'dart:convert';
import 'dart:developer';
import 'package:stonks/settings.dart';
import 'package:web_socket_channel/io.dart';


class LastPriceService {
  final _channel = IOWebSocketChannel.connect(SETTINGS.websocketUrl);

  Stream get stream => _channel.stream;

  subscribe(String prefix) {
    log('Subscribe $prefix lastPrice');
    _channel.sink.add(json.encode({'type': 'subscribe', 'symbol': prefix}));
  }

  unsubscribe(String prefix) {
    log('Unsubscribe  $prefix lastPrice');
    _channel.sink.add(json.encode({'type': 'unsubscribe', 'symbol': prefix}));
  }

  dispose() async => await _channel.sink.close();
}
