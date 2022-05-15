import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stonks/app_theme.dart';
import 'package:stonks/dependecy_injection.dart';
import 'package:stonks/presentation/BLoCs/listen_last_price_cubit.dart';
import 'package:stonks/presentation/BLoCs/search_stock_cubit.dart';
import 'package:stonks/presentation/screens/home_screen.dart';

import 'presentation/BLoCs/follow_stock_cubit.dart';

void main() async {
  await Hive.initFlutter();
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  setupDependency();
  runApp(const StonksApp());
}

class StonksApp extends StatelessWidget {
  const StonksApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stonks',
      theme: AppTheme().light,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<FollowStockCubit>(
            create: (_) => getIt<FollowStockCubit>()..loadFollowedStocks(),
          ),
          BlocProvider<SearchStockCubit>(
              create: (_) => getIt<SearchStockCubit>()),
          BlocProvider<ListenLastPriceCubit>(
            create: (_) =>
                getIt<ListenLastPriceCubit>()..setupConnectivityListner(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
