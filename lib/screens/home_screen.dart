import 'package:flutter/material.dart';
import 'package:stonks/errors/network_info.dart';
import 'package:stonks/widgets/connect_checker_text.dart';
import 'package:stonks/widgets/internet_not_connected_view.dart';
import '../widgets/current_date_view.dart';
import '../widgets/home_screen_body.dart';

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
            const CurrentDateView(),
          ],
        ),
      ),
      body: isLoading
          ? const ConnectCheckerText()
          : internetIsConnected
              ? HomeScreenBody()
              : InternetNotConnectedView(onRefresh: _onRefresh),
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
