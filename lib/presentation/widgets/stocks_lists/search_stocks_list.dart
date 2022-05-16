import 'package:flutter/material.dart';
import 'package:stonks/domain/entity/stock_entity.dart';

import '../stock_widgets/search_stock_widget.dart';

class SearchStocksList extends StatelessWidget {
  final List<StockEntity> stocks;
  final Widget emptyWidget;

  const SearchStocksList({
    Key? key,
    required this.stocks,
    required this.emptyWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) {
      return emptyWidget;
    }
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      addAutomaticKeepAlives: false,
      addSemanticIndexes: false,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      itemCount: stocks.length,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      itemBuilder: (context, index) => SearchStockWidget(
        stock: stocks[index],
        key: Key(stocks[index].ticker),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
