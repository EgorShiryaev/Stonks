import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo {
  final _connectionChecker = InternetConnectionChecker();

  Future<bool> get isConnected => _connectionChecker.hasConnection;
}
