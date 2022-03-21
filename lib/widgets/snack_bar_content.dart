import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';

import '../models/stock.dart';

class SnackBarContent extends StatefulWidget {
  final Stock stock;
  const SnackBarContent({Key? key, required this.stock}) : super(key: key);

  @override
  State<SnackBarContent> createState() => _SnackBarContentState();
}

class _SnackBarContentState extends State<SnackBarContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${widget.stock.prefix} удалён'),
        IconButton(
          onPressed: _onUndo,
          icon: const Icon(
            Icons.undo,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  _onUndo() {
    Provider.of<StocksProvider>(context, listen: false).add(widget.stock);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
