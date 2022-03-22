import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';
import 'package:stonks/widgets/empty_saved_stocks_list.dart';
import 'package:stonks/widgets/loading_indicator.dart';
import 'package:stonks/widgets/nothing_found_message.dart';
import 'package:stonks/widgets/search_stroke.dart';
import 'package:stonks/widgets/searched_stock_widget.dart';
import 'package:stonks/widgets/stock_widget.dart';

class HomeBody extends StatelessWidget {
  HomeBody({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<StocksProvider>(builder: (context, provider, child) {
      return ListView.separated(
        addAutomaticKeepAlives: false,
        addSemanticIndexes: false,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: _countItems(provider, provider.savedStocks.length),
        itemBuilder: (context, index) {
          if (index == 0) {
            return SearchStroke(controller: searchController);
          }
          if (index > 0 && index <= provider.savedStocks.length) {
            return StockWidget(stock: provider.savedStocks[index - 1]);
          }
          if (provider.loadingSavedStocks || provider.loadingSearchedStocks) {
            return const LoadingIndicator();
          }
          if (provider.savedStocks.isEmpty && !provider.searching) {
            return const EmptySavedStocksList();
          }
          if (!provider.loadingSearchedStocks &&
              provider.searchedStocks.isEmpty) {
            return const NothingFoundMessage();
          }
          return SearchedStockWidget(
            stock: provider
                .searchedStocks[index - provider.savedStocks.length - 1],
          );
        },
        separatorBuilder: (context, index) {
          if ((index == 0 || index == provider.savedStocks.length) &&
              provider.searching) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    index == 0 && provider.savedStocks.isNotEmpty
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

  int _countItems(StocksProvider provider, int lengthStocks) {
    //тк всегда есть поисковая строка сверху
    int count = 1;

    // когда лист нет отслеживаемых акции и не идет поиск и не фильтруется список сохраненных акций
    // или  когда идет загрузка отслеживаемых акций
    // добавляем один элемент либо для индикатора загрузки
    // либо для текста, что список пуст
    if (provider.savedStocks.isEmpty &&
            !provider.searching &&
            !provider.savesStoksIsFiltered ||
        provider.loadingSavedStocks) {
      count++;
    } else {
      count += lengthStocks;
    }

    // когда ничего не найдено и производится поиск поиск
    // или когда идет загрузка данных по запросу
    // добавляем один для текста, что ничего не найдено
    // либо для индикатора загрузки
    if (provider.searchedStocks.isEmpty && provider.searching ||
        provider.loadingSearchedStocks) {
      count++;
    } else {
      count += provider.searchedStocks.length;
    }

    return count;
  }
}
