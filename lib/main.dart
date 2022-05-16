import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app_theme.dart';
import 'dependecy_injection.dart';
import 'presentation/BLoCs/blocs.dart';
import 'presentation/screens/screens.dart';

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
