import 'package:flutter/material.dart';
import '../../../domain/entity/entities.dart';
import '../widgets.dart';

class FollowStocksList extends StatelessWidget {
  final List<StockEntity> stocks;
  final bool lastPriceServiceIsConnected;

  const FollowStocksList({
    Key? key,
    required this.stocks,
    required this.lastPriceServiceIsConnected,
  }) : super(key: key);

  static const emptyListText =
      'У вас нет отслеживаемых бумаг.\nЧтобы отслеживать бумагу необходимо найти ее в разделе "Поиск" и добавить.';

  @override
  Widget build(BuildContext context) {
    if (stocks.isEmpty) {
      return const CenterText(text: emptyListText);
    }
    return Scrollbar(
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        addAutomaticKeepAlives: false,
        addSemanticIndexes: false,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemCount: stocks.length,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        itemBuilder: (context, index) => FollowStockWidget(
          stock: stocks[index],
          lastPriceServiceIsConnected: lastPriceServiceIsConnected,
          key: Key(stocks[index].ticker),
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
