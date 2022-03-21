import 'package:flutter/material.dart';
import 'package:stonks/models/stock.dart';
import 'package:stonks/widgets/searched_stock_widget.dart';

class SearchedStocksView extends StatelessWidget {
  final List<Stock> searchedStocks;
  const SearchedStocksView({Key? key, required this.searchedStocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchedStocks.length,
      itemBuilder: (context, index) => SearchedStockWidget(stock: searchedStocks[index]),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
