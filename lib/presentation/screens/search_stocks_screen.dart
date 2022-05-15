import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/search_stock_cubit.dart';
import 'package:stonks/presentation/BLoCs/search_stock_state.dart';
import 'package:stonks/presentation/widgets/stock_widgets/stock_widget_type.dart';

import '../../domain/entity/stock_entity.dart';
import '../widgets/center_loader.dart';
import '../widgets/center_text.dart';
import '../widgets/search_stroke.dart';
import '../widgets/stocks_list.dart';

class SearchStocksScreen extends StatelessWidget {
  const SearchStocksScreen({Key? key}) : super(key: key);

  static final popularStocks = [
    StockEntity(ticker: 'AMZN', title: 'AMAZON.COM INC', price: 0),
    StockEntity(ticker: 'AAPL', title: 'APPLE INC', price: 0),
    StockEntity(ticker: 'GOOGL', title: 'ALPHABET INC-CL A', price: 0),
    StockEntity(ticker: 'MSFT', title: 'MICROSOFT CORP', price: 0),
    StockEntity(ticker: 'BINANCE:BTCUSDT', title: 'Binance BTC/USDT', price: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchStroke(
          search: BlocProvider.of<SearchStockCubit>(context).searchStocks,
          clear: BlocProvider.of<SearchStockCubit>(context).stopSearching,
        ),
        Expanded(
          child: BlocBuilder<SearchStockCubit, SearchStockState>(
            builder: (context, state) {
              if (state is SearchStockInitialState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15)
                          .copyWith(bottom: 0),
                      child: Text(
                        'Популярные акции:',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Expanded(
                      child: StocksList(
                        stocks: popularStocks,
                        emptyWidget: const SizedBox(),
                        childrenType: StockWidgetType.search,
                      ),
                    ),
                  ],
                );
              } else if (state is SearchStockLoadingState) {
                return const CenterLoader();
              } else if (state is SearchStockErrorState) {
                return CenterText(text: state.message);
              } else if (state is SearchStockLoadedState) {
                return StocksList(
                  stocks: state.stocks,
                  emptyWidget: CenterText(
                    text: 'По запросу "${state.query}" ничего не найдено',
                  ),
                  childrenType: StockWidgetType.search,
                );
              } else {
                return const CenterText(text: 'Неизвестное состояние');
              }
            },
          ),
        ),
      ],
    );
  }
}
