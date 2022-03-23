import 'package:flutter/material.dart';
import 'package:stonks/errors/network_info.dart';
import '../widgets/current_date.dart';
import '../widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final networkInfo = NetworkInfo();
  bool internetIsConnected = false;
  bool isLoading = true;

  @override
  void initState() {
    _checkInternet();
    super.initState();
  }

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
      body: isLoading
          ? Center(
              child: Text(
                'Проверка подключения к интернету...',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
            )
          : internetIsConnected
              ? HomeBody()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Нет подключения к интернету. Проверьте подключение и обновите страницу',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: _onRefresh,
                      icon: const Icon(Icons.refresh),
                      iconSize: 50,
                    )
                  ],
                ),
    );
  }

  _onRefresh() {
    setState(() {
      isLoading = true;
    });
    _checkInternet();
  }

  _checkInternet() {
    networkInfo.isConnected.then((value) {
      setState(() {
        isLoading = false;
        internetIsConnected = value;
      });
      return internetIsConnected = value;
    });
  }
}
