import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_cubit.dart';
import 'package:stonks/presentation/BLoCs/follow_stock_state.dart';
import 'package:stonks/presentation/widgets/follow_stocks_list.dart';

class FollowStocksScreen extends StatelessWidget {
  const FollowStocksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowStockCubit, FollowStockState>(
      builder: (context, state) {
        log(state.toString());
        if (state is FollowStockEmptyState) {
          return _buildEmptyFollowedStocks(context);
        } else if (state is FollowStockLoadingState) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is FollowStockErrorState) {
          return _buildError(context, state.message);
        } else if (state is FollowStockSearchedState) {
          return FollowStocksList(stocks: state.stocks);
        } else if (state is FollowStockLoadedState) {
          return FollowStocksList(stocks: state.stocks);
        } else {
          return _buildUnknowedState(context);
        }
      },
    );
  }

  Widget _buildEmptyFollowedStocks(BuildContext context) {
    return Center(
      child: Text(
        'У вас нет отслеживаемых бумаг.\nЧтобы отслеживать бумагу необходимо найти ее по поиску и добавить.',
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildUnknowedState(BuildContext context) {
    return Center(
      child: Text(
        'Неизвестная ошибка',
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
