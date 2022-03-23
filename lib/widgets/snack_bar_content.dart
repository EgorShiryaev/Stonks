import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';

import '../models/stock.dart';

class SnackBarContent extends StatelessWidget {
  final Stock stock;
  const SnackBarContent({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${stock.prefix} удалён'),
        IconButton(
          onPressed: () => _onUndo(context),
          icon: const Icon(
            Icons.undo,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  _onUndo(BuildContext context) {
    Provider.of<StocksProvider>(context, listen: false).add(stock);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
