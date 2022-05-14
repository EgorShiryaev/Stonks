import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_cubit.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_state.dart';
import 'package:stonks/presentation/widgets/center_text.dart';
import 'package:stonks/presentation/widgets/stocks_list.dart';
import 'package:stonks/presentation/widgets/search_stroke.dart';

import '../widgets/center_loader.dart';
import '../widgets/stonk_widgets/stock_widget_type.dart';

class FollowStocksScreen extends StatelessWidget {
  const FollowStocksScreen({Key? key}) : super(key: key);

  static const emptyListText =
      'У вас нет отслеживаемых бумаг.\nЧтобы отслеживать бумагу необходимо найти ее в разделе "Поиск" и добавить.';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchStroke(
          search: BlocProvider.of<FollowStockCubit>(context).searchStocks,
          clear: BlocProvider.of<FollowStockCubit>(context).loadFollowedStocks,
        ),
        Expanded(
          child: BlocBuilder<FollowStockCubit, FollowStockState>(
            builder: (context, state) {
              log(state.toString());
              if (state is FollowStockInitialState ||
                  state is FollowStockLoadingState) {
                return const CenterLoader();
              } else if (state is FollowStockErrorState) {
                return CenterText(text: state.message);
              } else if (state is FollowStockLoadedState) {
                log(state.stocks.toString());
                return StocksList(
                  stocks: state.stocks,
                  emptyWidget: const CenterText(text: emptyListText),
                  childrenType: StockWidgetType.follow,
                );
              } else if (state is FollowStockSearchedState) {
                return StocksList(
                  stocks: state.stocks,
                  emptyWidget: CenterText(
                    text: 'По запросу "${state.searchText}" ничего не найдено',
                  ),
                  childrenType: StockWidgetType.follow,
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
