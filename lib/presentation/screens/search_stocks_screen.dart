import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/search_stock_cubit.dart';
import 'package:stonks/presentation/BLoCs/search_stock_state.dart';
import 'package:stonks/presentation/widgets/stonk_widgets/stock_widget_type.dart';

import '../widgets/center_loader.dart';
import '../widgets/center_text.dart';
import '../widgets/search_stroke.dart';
import '../widgets/stocks_list.dart';

class SearchStocksScreen extends StatelessWidget {
  const SearchStocksScreen({Key? key}) : super(key: key);

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
              if (state is SearchStockLoadingState) {
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
