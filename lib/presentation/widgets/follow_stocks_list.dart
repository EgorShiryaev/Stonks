import 'package:flutter/material.dart';
import 'package:stonks/domain/entity/stock_entity.dart';

import 'follow_stock_widget.dart';

class FollowStocksList extends StatelessWidget {
  final List<StockEntity> stocks;
  const FollowStocksList({
    Key? key,
    required this.stocks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: stocks.length,
      itemBuilder: (context, index) => FollowStockWidget(stock: stocks[index]),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
