import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stonks/domain/entity/price_notification.dart';
import '../../../domain/entity/entities.dart';
import '../../BLoCs/blocs.dart';
import '../add_notification_modal.dart';
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
  PriceNotification? priceNotification;

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
    _checkCurrentStockIsSubscribe(oldWidget.stock.ticker, widget.stock.ticker);
    super.didUpdateWidget(oldWidget);
    _checkPrice(widget.stock.price);
  }

  @override
  void deactivate() {
    _unsubscribe(widget.stock.ticker);
    super.deactivate();
  }

  void _subscribe(String ticker) {
    if (widget.lastPriceServiceIsConnected) {
      BlocProvider.of<ListenLastPriceCubit>(context).subcribePrice(ticker);
    }
  }

  void _unsubscribe(String ticker) {
    if (widget.lastPriceServiceIsConnected) {
      BlocProvider.of<ListenLastPriceCubit>(context).unsubcribePrice(ticker);
    }
  }

  void _checkCurrentStockIsSubscribe(String oldTicker, String newTicker) {
    if (oldTicker != newTicker) {
      _unsubscribe(oldTicker);
      _subscribe(widget.stock.ticker);
      _removePriceNotification();
    }
  }

  void _onDismissed(_) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: UndoSnackBarContent(stock: widget.stock),
        duration: const Duration(seconds: 2),
      ),
    );
    BlocProvider.of<FollowStockCubit>(context).deleteStock(widget.stock);
  }

  void onPressNotificationIcon() {
    if (priceNotification == null) {
      _setupPriceNotification();
    } else {
      _removePriceNotification();
    }
  }

  void _setupPriceNotification() {
    _showSetupNotifiModal();
  }

  void saveNotificationPrice(PriceNotification newPriceNotification) {
    setState(() {
      priceNotification = newPriceNotification;
    });
  }

  void _removePriceNotification() {
    setState(() {
      priceNotification = null;
    });
  }

  Future<void> _showSetupNotifiModal() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AddNotificationModal(
            saveNotificationPrice: saveNotificationPrice);
      },
    );
  }

  void _checkPrice(int newPrice) {
    if (priceNotification != null) {
      if (priceNotification!.needNotify(newPrice)) {
        setState(() {
          priceNotification = null;
        });
        Timer.run(
          () => _showNotificationModal(newPrice),
        );
      }
    }
  }

  Future<void> _showNotificationModal(int newPrice) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Цена изменилась!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    'Цена ${widget.stock.title} ${(newPrice / 100).toStringAsFixed(2)} \$'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Ок',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
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
            IconButton(
              icon: Icon(
                priceNotification == null
                    ? Icons.notification_add
                    : Icons.notifications_off,
              ),
              onPressed: onPressNotificationIcon,
            ),
          ],
        ),
      ),
    );
  }
}
