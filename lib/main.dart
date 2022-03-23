import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:stonks/app_theme.dart';
import 'package:stonks/providers/stocks_provider.dart';
import 'package:stonks/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stonks',
      theme: AppTheme().light,
      home: ChangeNotifierProvider(
        create: (context) => StocksProvider()..init(),
        child: const HomeScreen(),
      ),
    );
  }
}
