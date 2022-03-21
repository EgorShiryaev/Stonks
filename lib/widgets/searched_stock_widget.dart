import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';

import '../models/stock.dart';

class SearchedStockWidget extends StatefulWidget {
  final Stock stock;
  const SearchedStockWidget({Key? key, required this.stock}) : super(key: key);

  @override
  State<SearchedStockWidget> createState() => _SearchedStockWidgetState();
}

class _SearchedStockWidgetState extends State<SearchedStockWidget> {
  @override
  Widget build(BuildContext context) {
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
                  widget.stock.prefix,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  widget.stock.description,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
          !Provider.of<StocksProvider>(context, listen: false)
                  .stocks
                  .any((ele) => ele.prefix == widget.stock.prefix)
              ? IconButton(
                  onPressed: _onAdd,
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

  _onAdd() {
    Provider.of<StocksProvider>(context, listen: false).add(widget.stock);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.stock.prefix} добавлена в лист отслеживания'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
