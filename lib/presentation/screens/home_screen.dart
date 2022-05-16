import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/entities.dart';
import '../BLoCs/blocs.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  bool lastPriceServiceIsConnected = false;

  onConnectService() => setState(() => lastPriceServiceIsConnected = true);

  onDisconnectService() => setState(() => lastPriceServiceIsConnected = false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StonksAppBarContent(),
      ),
      body: BlocListener<ListenLastPriceCubit, ListenLastPriceState>(
        listener: (context, state) {
          if (state is ListenLastPriceNewDataState) {
            _onNewDataState(context, state.stocks);
          } else if (state is ListenLastPriceConnectingState) {
            _onConnectingState(context);
          } else if (state is ListenLastPriceConnectedState) {
            _onConnectedState(context);
            onConnectService();
          } else if (state is ListenLastPriceDisconnectedState) {
            _onDisconnectedState(context);
            onDisconnectService();
          } else if (state is ListenLastPriceErrorConnectingState) {
            _onErrorConnectingState(context);
          }
        },
        child: _index == 0
            ? FollowStocksScreen(
                lastPriceServiceIsConnected: lastPriceServiceIsConnected,
              )
            : const SearchStocksScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) => setState(() => _index = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Мои акции',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
        ],
      ),
    );
  }

  void _onNewDataState(
    BuildContext context,
    List<StockEntity> stocks,
  ) {
    for (var stock in stocks) {
      BlocProvider.of<FollowStockCubit>(context).updateStockPrice(stock);
    }
  }

  void _showNewSnackBar(
    BuildContext context,
    Widget content,
    Duration duration,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        duration: duration,
      ),
    );
  }

  void _onConnectingState(BuildContext context) {
    _showNewSnackBar(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Подключение к серверу...'),
          CircularProgressIndicator.adaptive()
        ],
      ),
      const Duration(days: 1),
    );
  }

  void _onConnectedState(BuildContext context) {
    _showNewSnackBar(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Подключение установлено'),
          Icon(
            Icons.check,
            color: Colors.white,
          )
        ],
      ),
      const Duration(seconds: 2),
    );
  }

  void _onDisconnectedState(BuildContext context) {
    _showNewSnackBar(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Отсутвует подключение к серверу'),
          Icon(
            Icons.signal_wifi_off,
            color: Colors.white,
          )
        ],
      ),
      const Duration(days: 1),
    );
  }

  void _onErrorConnectingState(BuildContext context) {
    _showNewSnackBar(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Ошибка подключения к серверу'),
          Icon(
            Icons.error,
            color: Colors.white,
          )
        ],
      ),
      const Duration(days: 1),
    );
  }
}
