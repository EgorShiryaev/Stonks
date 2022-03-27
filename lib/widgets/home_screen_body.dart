import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';
import 'package:stonks/widgets/empty_saved_stocks_view.dart';
import 'package:stonks/widgets/loading_indicator_view.dart';
import 'package:stonks/widgets/nothing_found_view.dart';
import 'package:stonks/widgets/search_stroke.dart';
import 'package:stonks/widgets/searched_stock_widget.dart';
import 'package:stonks/widgets/server_error_view.dart';
import 'package:stonks/widgets/stock_widget.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({Key? key}) : super(key: key);
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
            return SavedStockWidget(stock: provider.savedStocks[index - 1]);
          }
          if (provider.loadingSavedStocks) {
            return LoadingIndicatorView(
              height: MediaQuery.of(context).size.height - 250,
            );
          }
          if (provider.loadingSearchedStocks) {
            return const LoadingIndicatorView(height: 200);
          }
          if (provider.savedStocks.isEmpty &&
              !provider.searching &&
              !(provider.errorIsConnectNetwork ||
                  provider.errorIsServerFailure)) {
            return const EmptySavedStocksView();
          }
          if (provider.errorIsConnectNetwork) {
            return const ErrorView(
              text:
                  'Произошла ошибка подключения к интернету.\n Проверьте подключение к интернету и попробуйте еще раз произвести поиск.',
            );
          }
          if (provider.errorIsServerFailure) {
            return const ErrorView(
              text:
                  'Произошла ошибка получения данных.\n Попробуйте еще раз произвести поиск позднее.',
            );
          }
          if (!provider.loadingSearchedStocks &&
              provider.searchedStocks.isEmpty) {
            return const NothingFoundView();
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

    // когда в листе нет отслеживаемых акции, не идет поиск и не фильтруется список сохраненных акций
    bool showEmptySavedStocksView = provider.savedStocks.isEmpty &&
        !provider.searching &&
        !provider.savesStoksIsFiltered;

    if (showEmptySavedStocksView || provider.loadingSavedStocks) {
      count++;
    } else {
      count += lengthStocks;
    }

    // когда данные поиска пустые и идет поиск
    bool showNothingFoundView =
        provider.searchedStocks.isEmpty && provider.searching;

    // когда возникла какая-либо ошибка и идет поиск
    bool showErrorView =
        (provider.errorIsConnectNetwork || provider.errorIsServerFailure) &&
            provider.searching;

    if (showNothingFoundView ||
        provider.loadingSearchedStocks ||
        showErrorView) {
      count++;
    } else {
      count += provider.searchedStocks.length;
    }

    return count;
  }
}
