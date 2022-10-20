import 'package:stonks/datasources/app_info_local_datasource.dart';
import 'package:stonks/datasources/stocks_local_datasources.dart';

class SETTINGS {
  static const _token = 'cd8jhfqad3i5t4lmarl0cd8jhfqad3i5t4lmarlg';

  static const _websocketBaseUrl = 'wss://ws.finnhub.io';
  static const _baseUrl = 'https://finnhub.io/api/v1';
  static const appInfoLocalDataSourceUrl = 'app_info';
  static const stocksLocalDataSourcesUrl = 'box_for_stocks';

  static get websocketUrl => Uri.parse('$_websocketBaseUrl?token=$_token');

  static Uri getUrl(String path) {
    return Uri.parse('$_baseUrl/$path&token=$_token');
  }
}
