import 'dart:async';
import 'dart:developer';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectionCheckerService {
  final InternetConnectionChecker _checker;

  ConnectionCheckerService({required InternetConnectionChecker checker})
      : _checker = checker;

  bool _internetIsConnect = false;

  bool get internetIsConnect => _internetIsConnect;

  final StreamController<bool> _connectionStreamController = StreamController();

  Stream<bool> get connectionStream => _connectionStreamController.stream;

  void setupListener() {
    _connectionStreamController.add(_internetIsConnect);
    _checker.onStatusChange.listen((event) {
      log(event.toString());
      if (event == InternetConnectionStatus.connected && !_internetIsConnect) {
        _internetIsConnect = true;
        _connectionStreamController.add(_internetIsConnect);
      } else if (event == InternetConnectionStatus.disconnected &&
          _internetIsConnect) {
        _internetIsConnect = false;
        _connectionStreamController.add(_internetIsConnect);
      }
    });
  }

  Future<void> dispose() async {
    await _connectionStreamController.close();
  }
}
