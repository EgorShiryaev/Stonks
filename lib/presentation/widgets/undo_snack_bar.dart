import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/entities.dart';
import '../BLoCs/blocs.dart';

class UndoSnackBarContent extends StatelessWidget {
  final StockEntity stock;
  const UndoSnackBarContent({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text('${stock.ticker} удалён из раздела "Мои акции"')),
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
