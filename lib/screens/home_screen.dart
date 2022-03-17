import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stonks/providers/finnhub_provider.dart';
import 'package:stonks/widgets/stock_view.dart';
import 'package:stonks/widgets/stonks_app_bar.dart';
import 'package:stonks/widgets/stonks_flexiable_appbar.dart';

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
          SliverToBoxAdapter(child: Consumer<FinnhubProvider>(
            builder: (context, finnhubProvider, child) {
              return StockView(stocks: finnhubProvider.stocks);
            },
          ))
        ],
      ),
    );
  }
}
