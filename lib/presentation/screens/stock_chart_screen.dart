import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stonks/domain/entity/entities.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../settings.dart';

class StockChartScreen extends StatefulWidget {
  final StockEntity stock;
  const StockChartScreen({Key? key, required this.stock}) : super(key: key);

  @override
  State<StockChartScreen> createState() => _StockChartScreenState();
}

class _StockChartScreenState extends State<StockChartScreen> {
  DateTime from = DateTime.now();
  final DateTime to = DateTime.now().subtract(Duration(days: 1));

  bool isLoading = true;
  List<ChartData> candelsData = [];

  @override
  void initState() {
    super.initState();
    setFrom(30);
  }

  void setFrom(int days) {
    setState(() {
      from = DateTime.now().subtract(Duration(days: days));
    });
    getCharts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.stock.title)),
      body: Column(
        children: [
          Expanded(
            child: Builder(
              builder: (context) {
                if (!isLoading) {
                  if (candelsData.isNotEmpty) {
                    return SfCartesianChart(
                      series: [
                        CandleSeries<ChartData, DateTime>(
                          dataSource: candelsData,
                          xValueMapper: (ChartData data, _) => data.dt,
                          lowValueMapper: (ChartData data, _) => data.low,
                          highValueMapper: (ChartData data, _) => data.hight,
                          openValueMapper: (ChartData data, _) => data.open,
                          closeValueMapper: (ChartData data, _) => data.close,
                        ),
                      ],
                      primaryXAxis: DateTimeAxis(),
                    );
                  } else {
                    return const Center(
                      child: Text('Нет данных'),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getCharts() async {
    log('/stock/candle?symbol=${widget.stock.ticker}&resolution=60&from=${from.toUtc().millisecondsSinceEpoch}&to=${to.toUtc().millisecondsSinceEpoch}');
    final response = await Client().get(Uri.parse(
        'https://finnhub.io/api/v1/stock/candle?symbol=${widget.stock.ticker}&resolution=D&from=${from.millisecond}&to=${to.millisecond}&token=c8n2dviad3id1m4i8emg'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> candels =
          json.decode(response.body) as Map<String, dynamic>;

      try {
        final data = CandelsApiData.fromApi(candels);
        final newData = data.generateChartData();
        setState(() {
          candelsData = newData;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          candelsData = [];
          isLoading = false;
        });
      }
    } else {
      setState(() {
        candelsData = [];
        isLoading = false;
      });
    }
  }
}

class ChartData {
  final DateTime dt;
  final num open;
  final num close;
  final num low;
  final num hight;

  ChartData({
    required this.dt,
    required this.open,
    required this.close,
    required this.low,
    required this.hight,
  });
}

class CandelsApiData {
  final List dt;
  final List open;
  final List close;
  final List low;
  final List hight;

  CandelsApiData(
      {required this.dt,
      required this.open,
      required this.close,
      required this.low,
      required this.hight});

  factory CandelsApiData.fromApi(Map<String, dynamic> json) {
    return CandelsApiData(
      close: json['c'] as List,
      open: json['o'] as List,
      hight: json['h'] as List,
      low: json['l'] as List,
      dt: json['t'] as List,
    );
  }

  List<ChartData> generateChartData() {
    List<ChartData> charts = [];

    for (var i = 0; i < close.length; i++) {
      charts.add(
        ChartData(
          dt: DateTime.fromMillisecondsSinceEpoch(dt[i] as int),
          open: open[i] as num,
          close: close[i] as num,
          low: low[i] as num,
          hight: hight[i] as num,
        ),
      );
    }
    return charts;
  }
}
