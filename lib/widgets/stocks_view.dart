import 'package:flutter/material.dart';
import 'package:stonks/widgets/stock_widget.dart';
import '../models/stock.dart';

class StockView extends StatelessWidget {
  final List<Stock> stocks;
  const StockView({Key? key, required this.stocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: stocks.length,
      itemBuilder: (context, index) => StockWidget(stock: stocks[index]),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
