import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/entities.dart';
import '../../BLoCs/blocs.dart';
import '../widgets.dart';

class FollowStockWidget extends StatefulWidget {
  final bool lastPriceServiceIsConnected;
  final StockEntity stock;
  const FollowStockWidget({
    Key? key,
    required this.stock,
    required this.lastPriceServiceIsConnected,
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
  void didUpdateWidget(covariant FollowStockWidget oldWidget) {
    if (!oldWidget.lastPriceServiceIsConnected &&
        widget.lastPriceServiceIsConnected) {
      _subscribe(widget.stock.ticker);
    }
    _checkCurrentStockIsSubscribe();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    _unsubscribe(widget.stock.ticker);
    super.deactivate();
  }

  _subscribe(String ticker) {
    if (widget.lastPriceServiceIsConnected) {
      BlocProvider.of<ListenLastPriceCubit>(context).subcribePrice(ticker);
      lastSubscribeTicker = ticker;
    }
  }

  _unsubscribe(String ticker) {
    if (widget.lastPriceServiceIsConnected) {
      BlocProvider.of<ListenLastPriceCubit>(context).unsubcribePrice(ticker);
      lastSubscribeTicker = '';
    }
  }

  _checkCurrentStockIsSubscribe() {
    if (lastSubscribeTicker != widget.stock.ticker &&
        lastSubscribeTicker.isNotEmpty) {
      _unsubscribe(lastSubscribeTicker);
      _subscribe(widget.stock.ticker);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.stock.ticker,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    widget.stock.title,
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
        content: UndoSnackBarContent(stock: widget.stock),
        duration: const Duration(seconds: 2),
      ),
    );
    BlocProvider.of<FollowStockCubit>(context).deleteStock(widget.stock);
  }
}
