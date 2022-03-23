import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';

import '../models/stock.dart';

class SearchedStockWidget extends StatelessWidget {
  final Stock stock;
  const SearchedStockWidget({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thisStockIsSaved = Provider.of<StocksProvider>(context, listen: false)
        .savedStocks
        .any((ele) => ele.prefix == stock.prefix);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.prefix,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  stock.description,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
          !thisStockIsSaved
              ? IconButton(
                  onPressed: () => _onAdd(context),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  _onAdd(BuildContext context) {
    Provider.of<StocksProvider>(context, listen: false).add(stock);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${stock.prefix} добавлена в лист отслеживания'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
