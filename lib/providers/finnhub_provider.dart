import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:stonks/models/stock.dart';
import 'package:stonks/settings.dart';
import 'package:web_socket_channel/io.dart';

class FinnhubProvider extends ChangeNotifier {
  List<Stock> stocks = [
    Stock(prefix: 'AAPL', lastPrice: 0, description: 'APPLE INC'),
    Stock(prefix: 'AMZN', lastPrice: 0, description: 'AMAZON INC'),
    Stock(prefix: 'BINANCE:BTCUSDT', lastPrice: 0, description: 'BITCOIN'),
    Stock(prefix: 'IC MARKETS:1', lastPrice: 0, description: 'APPLE INC'),
  ];

  final _channel = IOWebSocketChannel.connect(SETTINGS.websocketUrl);

  start() {
    for (var element in stocks) {
      _addToSink('subscribe', element.prefix);
    }
    _channel.stream.listen((event) {
      final List<dynamic>? data = json.decode(event)['data'];
      if (data == null) {
        return;
      }
      stocks = stocks.map((stock) {
        final element = data.firstWhere(
            (element) => element['s'] == stock.prefix,
            orElse: () => null);
        if (element != null) {
          stock.updateLastPrice('${element['p']}');
          log('${stock.prefix} : ${stock.lastPrice}');
        }
        return stock;
      }).toList();

      notifyListeners();
    });
  }

  subscribe(String prefix, String description) {
    if (!stocks.any((element) => element.prefix == prefix)) {
      stocks.add(Stock(
        prefix: prefix,
        lastPrice: 0,
        description: description,
      ));
      _channel.sink.add(json.encode({'type': 'subscribe', 'symbol': prefix}));
      _addToSink('subscribe', prefix);
    }
  }

  unsubscride(String prefix) {
    stocks.removeWhere((element) => element.prefix == prefix);
    _addToSink('unsubscribe', prefix);
  }

  _addToSink(String action, String prefix) {
    _channel.sink.add(
      json.encode({'type': action, 'symbol': prefix}),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
