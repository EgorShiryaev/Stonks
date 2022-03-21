
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/widgets/snack_bar_content.dart';

import '../models/stock.dart';
import '../providers/stocks_provider.dart';

class StockWidget extends StatefulWidget {
  final Stock stock;
  const StockWidget({Key? key, required this.stock}) : super(key: key);

  @override
  State<StockWidget> createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  bool needSubscribe = true;

  @override
  void deactivate() {
    Provider.of<StocksProvider>(context)
        .unsubscribeToLastPrice(widget.stock.prefix);
    needSubscribe = true;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (needSubscribe) {
      Provider.of<StocksProvider>(context)
          .subscribeToLastPrice(widget.stock.prefix);
      needSubscribe = false;
    }
    return Dismissible(
      key: Key(widget.stock.prefix),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.white,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.black,
          size: 32.0,
        ),
      ),
      onDismissed: _onDismissed,
      child: Padding(
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
            widget.stock.lastPrice != 0
                ? Text(
                    '${(widget.stock.lastPrice).toStringAsFixed(2)} \$',
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                : const Icon(Icons.av_timer),
          ],
        ),
      ),
    );
  }

  _onDismissed(_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SnackBarContent(stock: widget.stock),
        duration: const Duration(seconds: 1),
      ),
    );
    Provider.of<StocksProvider>(context, listen: false)
        .delete(widget.stock.prefix);
  }
}
