
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';
import 'package:stonks/widgets/search_stroke.dart';
import 'package:stonks/widgets/searched_stock_widget.dart';
import 'package:stonks/widgets/stock_widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<StocksProvider>(builder: (context, provider, child) {
      final stocks = provider.stocks.where((element) {
        final lowercaseSearchedText = searchController.text.toLowerCase();
        return element.prefix.toLowerCase().contains(lowercaseSearchedText) ||
            element.description.toLowerCase().contains(lowercaseSearchedText);
      }).toList();
      final itemCount = 1 +
          (provider.stocks.isEmpty && !provider.searching || provider.savedStocksIsLoading ? 1 : stocks.length) +
          (provider.searchedStocks.isEmpty && provider.searching ||
                  provider.searchStocksIsLoading
              ? 1
              : provider.searchedStocks.length);
      return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == 0) {
            return SearchStroke(controller: searchController);
          }
          if (index > 0 && index <= stocks.length) {
            return StockWidget(stock: stocks[index - 1]);
          }
          if (provider.savedStocksIsLoading || provider.searchStocksIsLoading) {
            return const SizedBox(
              height: 200,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }
          if (provider.stocks.isEmpty && !provider.searching) {
            return SizedBox(
              height: 500,
              child: Center(
                child: Text(
                  'У вас нет отслеживаемых бумаг.\nЧтобы отслеживать бумагу необходимо найти ее по поиску и добавить.',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (!provider.searchStocksIsLoading &&
              provider.searchedStocks.isEmpty) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'По запросу «${searchController.text}» ничего не найдено',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return SearchedStockWidget(
            stock: provider.searchedStocks[index - stocks.length - 1],
          );
        },
        separatorBuilder: (context, index) {
          if ((index == 0 || index == stocks.length) && provider.searching) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    index == 0 && stocks.isNotEmpty
                        ? 'Отслеживаемые бумаги:'
                        : 'Результаты поиска:',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const Divider(),
              ],
            );
          }

          return const Divider();
        },
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
      );
    });
  }
}
