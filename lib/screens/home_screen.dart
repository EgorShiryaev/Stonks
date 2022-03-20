import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/prefix_provider.dart';
import 'package:stonks/widgets/prefix_view.dart';
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
          SliverToBoxAdapter(child: Consumer<PrefixProvider>(
              builder: (context, prefixProvider, child) {
            if (prefixProvider.loading) {
              return _loadingIndicator();
            }
            if (prefixProvider.prefixes.isNotEmpty) {
              return PrefixView(prefixes: prefixProvider.prefixes);
            }
            return Consumer<StocksProvider>(
              builder: (context, stocksProvider, child) {
                if (stocksProvider.loading) {
                  return _loadingIndicator();
                }
                return StockView(stocks: stocksProvider.stocks);
              },
            );
          }))
        ],
      ),
    );
  }

  _loadingIndicator() => SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
      );
}
