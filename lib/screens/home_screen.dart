import 'package:flutter/material.dart';
import '../widgets/current_date.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Stonks', style: Theme.of(context).textTheme.subtitle1),
            const CurrentDate(),
          ],
        ),
      ),
      body: const HomeBody(),
    );
  }

  
}
