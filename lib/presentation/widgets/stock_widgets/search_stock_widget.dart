import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/entities.dart';
import '../../BLoCs/blocs.dart';

class SearchStockWidget extends StatelessWidget {
  final StockEntity stock;
  const SearchStockWidget({Key? key, required this.stock}) : super(key: key);

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
                  stock.ticker,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  stock.title,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () => _onAdd(context),
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  _onAdd(BuildContext context) {
    BlocProvider.of<FollowStockCubit>(context).addStock(stock);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${stock.ticker} добавлен в раздел "Мои акции"'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
