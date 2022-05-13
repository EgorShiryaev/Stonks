import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:stonks/app_theme.dart';
import 'package:stonks/dependecy_injection.dart';
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
      home: MultiProvider(
        providers: [
          Provider<FollowStockCubit>(
              create: (_) => getIt<FollowStockCubit>()..loadFollowedStocks()),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
