import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        Text('${stock.ticker} удалён из раздела "Мои акции"'),
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
    BlocProvider.of<FollowStockCubit>(context).addStock(stock);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
