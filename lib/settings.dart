class SETTINGS {
  static const String _token = 'c8n2dviad3id1m4i8emg';
  static const String _sandboxToken = 'sandbox_c8n2dviad3id1m4i8en0';
  static const String _websocketBaseUrl = 'wss://ws.finnhub.io';
  static const String _baseUrl = 'https://finnhub.io/api/v1';

  static get websocketUrl => Uri.parse('$_websocketBaseUrl?token=$_token');

  static getUrl(String path) => Uri.parse('$_baseUrl/$path&token=$_sandboxToken');
}
