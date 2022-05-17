import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/entities.dart';
import '../BLoCs/blocs.dart';
import '../widgets/widgets.dart';

class SearchStocksScreen extends StatelessWidget {
  const SearchStocksScreen({Key? key}) : super(key: key);

  static final popularStocks = [
    StockEntity(ticker: 'AAPL', title: 'APPLE INC', price: 0),
    StockEntity(ticker: 'AMZN', title: 'AMAZON.COM INC', price: 0),
    StockEntity(ticker: 'BINANCE:BTCUSDT', title: 'Binance BTC/USDT', price: 0),
    StockEntity(ticker: 'CPRT', title: 'COPART INC', price: 0),
    StockEntity(ticker: 'CRL', title: 'CHARLES RIVER LABORATORIES', price: 0),
    StockEntity(ticker: 'EFX', title: 'EQUIFAX INC', price: 0),
    StockEntity(ticker: 'FLR', title: 'FLUOR CORP', price: 0),
    StockEntity(ticker: 'FLT', title: 'FLEETCOR TECHNOLOGIES INC', price: 0),
    StockEntity(ticker: 'GOOGL', title: 'ALPHABET INC-CL A', price: 0),
    StockEntity(ticker: 'MSFT', title: 'MICROSOFT CORP', price: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchStroke(),
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
                      child: SearchStocksList(
                        stocks: popularStocks,
                        emptyWidget: const SizedBox(),
                      ),
                    ),
                  ],
                );
              } else if (state is SearchStockLoadingState) {
                return const CenterLoader();
              } else if (state is SearchStockErrorState) {
                return CenterText(text: state.message);
              } else if (state is SearchStockLoadedState) {
                return SearchStocksList(
                  stocks: state.stocks,
                  emptyWidget: CenterText(
                    text: 'По запросу "${state.query}" ничего не найдено',
                  ),
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
