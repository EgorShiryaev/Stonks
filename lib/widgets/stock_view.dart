import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';

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
      itemBuilder: (context, index) => Dismissible(
        key: Key(stocks[index].prefix),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        onDismissed: (direction) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${stocks[index].description} удален')),
          );
          Provider.of<StocksProvider>(context, listen: false)
              .delete(stocks[index].prefix);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stocks[index].prefix,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(stocks[index].description)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${(stocks[index].lastPrice).toStringAsFixed(2)} \$',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  stocks[index].lastPrice != 0.0
                      ? const SizedBox()
                      : const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.av_timer,
                            size: 24,
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Divider(color: Colors.grey.shade700),
      ),
    );
  }
}
