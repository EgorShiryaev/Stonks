import 'package:flutter/material.dart';
import 'package:stonks/domain/entity/stock_entity.dart';
import 'package:stonks/presentation/widgets/stock_widgets/follow_stock_widget.dart';
import 'package:stonks/presentation/widgets/stock_widgets/search_stock_widget.dart';
import 'package:stonks/presentation/widgets/stock_widgets/stock_widget_type.dart';

class StocksList extends StatelessWidget {
  final List<StockEntity> stocks;
  final Widget emptyWidget;
  final StockWidgetType childrenType;

  const StocksList({
    Key? key,
    required this.stocks,
    required this.emptyWidget,
    required this.childrenType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) {
      return emptyWidget;
    }
    return ListView.separated(
      addAutomaticKeepAlives: false,
      addSemanticIndexes: false,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      itemCount: stocks.length,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        switch (childrenType) {
          case StockWidgetType.follow:
            return FollowStockWidget(stock: stock, key: Key(stock.ticker));
          case StockWidgetType.search:
            return SearchStockWidget(stock: stock, key: Key(stock.ticker));
          default:
            return const Text('UNKNOW CHILDREN TYPE');
        }
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
