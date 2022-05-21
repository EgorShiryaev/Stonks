class SETTINGS {
  static const _token = 'c8n2dviad3id1m4i8emg';
  static const _sandboxToken = 'sandbox_c8n2dviad3id1m4i8en0';
  static const _websocketBaseUrl = 'wss://ws.finnhub.io';
  static const _baseUrl = 'https://finnhub.io/api/v1';
  static const stocksLocalDataSourcesId = 'box_for_stocks';

  static String get websocketUrl => '$_websocketBaseUrl?token=$_token';

  static Uri getUrl(String path) =>
      Uri.parse('$_baseUrl/$path&token=$_sandboxToken');
}
