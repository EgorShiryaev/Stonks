import 'dart:convert';
import 'dart:developer';
import 'package:stonks/settings.dart';
import 'package:web_socket_channel/io.dart';

import '../models/stock.dart';

class LastPriceService {
  final _channel = IOWebSocketChannel.connect(SETTINGS.websocketUrl);

  Stream get stream => _channel.stream;

  init(List<Stock> stocks) {
    for (var element in stocks) {
      subscribe(element.prefix);
    }
  }

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
