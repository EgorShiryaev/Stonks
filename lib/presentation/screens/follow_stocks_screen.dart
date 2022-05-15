import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_cubit.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_state.dart';
import 'package:stonks/presentation/BLoCs/listen_last_price_cubit.dart';
import 'package:stonks/presentation/BLoCs/listen_last_price_state.dart';
import 'package:stonks/presentation/widgets/center_text.dart';
import 'package:stonks/presentation/widgets/stocks_list.dart';
import 'package:stonks/presentation/widgets/search_stroke.dart';

import '../widgets/center_loader.dart';
import '../widgets/stock_widgets/stock_widget_type.dart';

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
        BlocListener<ListenLastPriceCubit, ListenLastPriceState>(
          listener: (context, state) {
            if (state is ListenLastPriceNewDataState) {
              for (var stock in state.stocks) {
                BlocProvider.of<FollowStockCubit>(context)
                    .updateStockPrice(stock);
              }
              return;
            }
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Widget content = const SizedBox();
            Duration duration = const Duration(seconds: 1);
            if (state is ListenLastPriceConnectingState) {
              content = Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Подключение к серверу...'),
                  CircularProgressIndicator.adaptive()
                ],
              );
              duration = const Duration(days: 1);
            } else if (state is ListenLastPriceConnectedState) {
              content = Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Подключение установлено'),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                ],
              );
              duration = const Duration(seconds: 1);
            } else if (state is ListenLastPriceDisconnectedState) {
              content = Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Отсутвует подключение к серверу'),
                  Icon(
                    Icons.signal_wifi_off,
                    color: Colors.white,
                  )
                ],
              );
              duration = const Duration(days: 1);
            } else if (state is ListenLastPriceDisconnectedState) {
              content = Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Ошибка подключения к серверу'),
                  Icon(
                    Icons.error,
                    color: Colors.white,
                  )
                ],
              );
              duration = const Duration(days: 1);
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: content,
                duration: duration,
              ),
            );
          },
          child: Expanded(
            child: BlocBuilder<FollowStockCubit, FollowStockState>(
              builder: (context, state) {
                if (state is FollowStockInitialState ||
                    state is FollowStockLoadingState) {
                  return const CenterLoader();
                } else if (state is FollowStockErrorState) {
                  return CenterText(text: state.message);
                } else if (state is FollowStockLoadedState) {
                  return StocksList(
                    stocks: state.stocks,
                    emptyWidget: const CenterText(text: emptyListText),
                    childrenType: StockWidgetType.follow,
                  );
                } else if (state is FollowStockSearchedState) {
                  return StocksList(
                    stocks: state.stocks,
                    emptyWidget: CenterText(
                      text:
                          'По запросу "${state.searchText}" ничего не найдено',
                    ),
                    childrenType: StockWidgetType.follow,
                  );
                } else {
                  return const CenterText(text: 'Неизвестное состояние');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
