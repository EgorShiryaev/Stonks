import 'package:stonks/core/stonks_exception.dart';

class ExceptionConvector {
  String convertToMessage(Exception e) {
    if (e is StonksException) {
      return e.message;
    } else {
      return 'Неизвестная ошибка! Проверьте подключение к интернету и переустановите приложение.';
    }
  }
}
