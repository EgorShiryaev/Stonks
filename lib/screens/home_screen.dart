import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/stocks_provider.dart';
import '../widgets/stock_view.dart';
import '../widgets/stonks_app_bar.dart';
import '../widgets/stonks_flexiable_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: StonksAppBar(),
            toolbarHeight: 70,
            shadowColor: Color(0x00000000),
            centerTitle: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: StonksFlexibleAppBar(),
            ),
            expandedHeight: 150.0,
          ),
          SliverToBoxAdapter(child: Consumer<StocksProvider>(
            builder: (context, stocksProvider, child) {
              if (stocksProvider.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              return StockView(stocks: stocksProvider.stocks);
            },
          ))
        ],
      ),
    );
  }
}
