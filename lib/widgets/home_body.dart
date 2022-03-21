import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/stocks_provider.dart';
import 'package:stonks/widgets/search_stroke.dart';
import 'package:stonks/widgets/searched_stocks_view.dart';
import 'package:stonks/widgets/stocks_view.dart';

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
      return ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
        children: [
          SearchStroke(controller: searchController),
          provider.savedStockisLoading ?_loadingIndicator() :  _buildSubscribedView(provider),
          provider.searching ? _buildSearchedView(provider) : const SizedBox(),
        ],
      );
    });
  }

  _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildSubscribedView(StocksProvider provider) {
    final stocks = provider.stocks.where((element) {
      final lowercaseSearchedText = searchController.text.toLowerCase();
      return element.prefix.toLowerCase().contains(lowercaseSearchedText) ||
          element.description.toLowerCase().contains(lowercaseSearchedText);
    }).toList();

    return stocks.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              provider.searching
                  ? _sectionTitle('Отслеживаемые бумаги')
                  : const SizedBox(),
              const Divider(),
              StockView(stocks: stocks),
            ],
          )
        : const SizedBox();
  }

  Widget _buildSearchedView(StocksProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Результаты поиска'),
        const Divider(),
        provider.searchStocksIsLoading
            ? _loadingIndicator()
            : SearchedStocksView(searchedStocks: provider.searchedStock)
      ],
    );
  }

  _loadingIndicator() => const SizedBox(
        height: 100,
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
