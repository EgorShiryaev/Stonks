class SETTINGS {
  static const _websocketBaseUrl = 'wss://ws.finnhub.io';
  static const _baseUrl = 'https://finnhub.io/api/v1';
  static const stocksLocalDataSourcesId = 'box_for_stocks';

  static String get websocketUrl => '$_websocketBaseUrl?token=$_token';

 static const _token = 'cd8jhfqad3i5t4lmarl0cd8jhfqad3i5t4lmarlg';
  static Uri getUrl(String path) {
    return Uri.parse('$_baseUrl/$path&token=$_token');
  }
}
