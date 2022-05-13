import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/domain/entity/stock_entity.dart';
import 'package:stonks/presentation/widgets/snack_bar_content.dart';

class FollowStockWidget extends StatefulWidget {
  final StockEntity stock;
  const FollowStockWidget({
    Key? key,
    required this.stock,
  }) : super(key: key);

  @override
  State<FollowStockWidget> createState() => _FollowStockWidgetState();
}

class _FollowStockWidgetState extends State<FollowStockWidget> {
  String lastSubscribeTicker = '';

  @override
  void initState() {
    _subscribe(widget.stock.ticker);
    super.initState();
  }

  @override
  void deactivate() {
    _unsubscribe(widget.stock.ticker);
    super.deactivate();
  }

  _subscribe(String prefix) {
    Provider.of<StocksProvider>(context, listen: false)
        .subscribeToLastPrice(prefix);
    lastSubscribeTicker = prefix;
  }

  _unsubscribe(String prefix) {
    Provider.of<StocksProvider>(context, listen: false)
        .unsubscribeToLastPrice(prefix);
    lastSubscribeTicker = '';
  }

  _checkCurrentStockIsSubscribe() {
    if (lastSubscribeTicker != widget.stock.ticker &&
        lastSubscribeTicker.isNotEmpty) {
      _unsubscribe(lastSubscribeTicker);
      _subscribe(widget.stock.ticker);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _checkCurrentStockIsSubscribe();
    return Dismissible(
      key: Key(widget.stock.ticker),
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
                    widget.stock.title,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    widget.stock.ticker,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
            widget.stock.price != 0
                ? Text(
                    '${(widget.stock.price / 100).toStringAsFixed(2)} \$',
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                : const Icon(Icons.av_timer),
          ],
        ),
      ),
    );
  }

  _onDismissed(_) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SnackBarContent(stock: widget.stock),
        duration: const Duration(seconds: 2),
      ),
    );
    Provider.of<StocksProvider>(context, listen: false)
        .delete(widget.stock.ticker);
  }
}
