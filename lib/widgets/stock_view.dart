import 'package:flutter/material.dart';

import '../models/stock.dart';

class StockView extends StatelessWidget {
  final List<Stock> stocks;
  const StockView({
    Key? key,
    required this.stocks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: stocks.length,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              stocks[index].prefix,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              '${(stocks[index].lastPrice).toStringAsFixed(2)} \$',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Divider(
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
