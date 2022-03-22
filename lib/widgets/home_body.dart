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
      return ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: _countItems(provider, stocks.length),
        itemBuilder: (context, index) {
          if (index == 0) {
            return SearchStroke(controller: searchController);
          }
          if (index > 0 && index <= stocks.length) {
            return StockWidget(stock: stocks[index - 1]);
          }
          if (provider.savedStocksIsLoading || provider.searchStocksIsLoading) {
            return _loadingIndicator();
          }
          if (provider.stocks.isEmpty && !provider.searching) {
            return _emptyList();
          }
          if (!provider.searchStocksIsLoading &&
              provider.searchedStocks.isEmpty) {
            return _nothingFound();
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

  Widget _loadingIndicator() => const SizedBox(
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

  Widget _emptyList() => SizedBox(
        height: 500,
        child: Center(
          child: Text(
            'У вас нет отслеживаемых бумаг.\nЧтобы отслеживать бумагу необходимо найти ее по поиску и добавить.',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget _nothingFound() => SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'По запросу «${searchController.text}» ничего не найдено',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ),
      );

  int _countItems(StocksProvider provider, int lengthStocks) {
    //тк всегда есть поисковая строка сверху
    int count = 1;

    // когда лист нет отслеживаемых акции и не идет поиск
    // или  когда идет загрузка отслеживаемых акций
    // добавляем один элемент либо для индиактора загрузки
    // либо для текста, что список пуст
    if (provider.stocks.isEmpty && !provider.searching ||
        provider.savedStocksIsLoading) {
      count++;
    } else {
      count += lengthStocks;
    }

    // когда ничего не найдено и производится поиск поиск
    // или когда идет загрузка данных по запросу
    // добавляем один для текста, что ничего не найдено
    // либо для индикатора загрузки
    if (provider.searchedStocks.isEmpty && provider.searching ||
        provider.searchStocksIsLoading) {
      count++;
    } else {
      count += provider.searchedStocks.length;
    }

    return count;
  }
}
