class SETTINGS {
  static const _token = 'c8n2dviad3id1m4i8emg';
  static const _sandboxToken = 'sandbox_c8n2dviad3id1m4i8en0';
  static const _websocketBaseUrl = 'wss://ws.finnhub.io';
  static const _baseUrl = 'https://finnhub.io/api/v1';
  static const appInfoLocalDataSourceUrl = 'app_info';
  static const stocksLocalDataSourcesUrl = 'box_for_stocks';

  static get websocketUrl => Uri.parse('$_websocketBaseUrl?token=$_token');

  static getUrl(String path) =>
      Uri.parse('$_baseUrl/$path&token=$_sandboxToken');
}
