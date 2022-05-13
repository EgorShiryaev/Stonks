import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/domain/entity/stock_entity.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_cubit.dart';

class SnackBarContent extends StatelessWidget {
  final StockEntity stock;
  const SnackBarContent({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${stock.ticker} удалён'),
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
    Provider.of<FollowStockCubit>(context).addStock(stock);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
