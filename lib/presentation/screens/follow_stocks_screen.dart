import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_cubit.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_state.dart';
import 'package:stonks/presentation/widgets/center_text.dart';

import '../widgets/center_loader.dart';
import '../widgets/stocks_lists/follow_stocks_list.dart';

class FollowStocksScreen extends StatelessWidget {
  final bool lastPriceServiceIsConnected;
  const FollowStocksScreen({Key? key, required this.lastPriceServiceIsConnected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowStockCubit, FollowStockState>(
      builder: (context, state) {
        if (state is FollowStockLoadingState) {
          return const CenterLoader();
        } else if (state is FollowStockErrorState) {
          return CenterText(text: state.message);
        } else if (state is FollowStockLoadedState) {
          return FollowStocksList(
            stocks: state.stocks,
            lastPriceServiceIsConnected: lastPriceServiceIsConnected,
          );
        } else {
          return const CenterText(text: 'Инициализация...');
        }
      },
    );
  }
}
