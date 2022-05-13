import 'package:flutter/material.dart';
import 'package:stonks/domain/entity/stock_entity.dart';
import 'package:stonks/presentation/widgets/search_stroke.dart';

import 'follow_stock_widget.dart';

class FollowStocksList extends StatefulWidget {
  final List<StockEntity> stocks;
  const FollowStocksList({
    Key? key,
    required this.stocks,
  }) : super(key: key);

  @override
  State<FollowStocksList> createState() => _FollowStocksListState();
}

class _FollowStocksListState extends State<FollowStocksList> {
  final scrollController = ScrollController(initialScrollOffset: 50);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: widget.stocks.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SearchStroke();
        } else {
          final stock = widget.stocks[index];
          return FollowStockWidget(stock: stock, key: Key(stock.ticker));
        }
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
