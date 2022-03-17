import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:stonks/app_theme.dart';
import 'package:stonks/providers/finnhub_provider.dart';
import 'screens/home_screen.dart';

void main() {
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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FinnhubProvider()..start(),
          )
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
