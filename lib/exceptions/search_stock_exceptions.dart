import 'exceptions.dart';

class InternetConnectionException implements StonksException {
  @override
  String get message => 'Отсутсвует подключение к интернету! Проверьте подключение и повторите попытку.';
}

class ServerException implements StonksException {
  @override
  String get message => 'Ошибка сервера! Повторите попытку позже.';
}