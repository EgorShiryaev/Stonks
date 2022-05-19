import 'exceptions.dart';

class DatabaseException implements StonksException {
  @override
  String get message => 'Ошибка хранилища данных! Переустановите приложение.';
}

class LoadFollowedStocksException implements StonksException {
  @override
  String get message =>
      'Ошибка загрузки отслеживаемых акций.\nПереустановите приложение!';
}

class AddStockException implements StonksException {
  final String _ticker;

  AddStockException({required String ticker}) : _ticker = ticker;

  @override
  String get message =>
      'Ошибка добавления акции $_ticker в список отслеживаемых.';
}

class UpdateStockPriceException implements StonksException {
  final String _ticker;

  UpdateStockPriceException({required String ticker}) : _ticker = ticker;

  @override
  String get message => 'Ошибка обновления цены акции $_ticker';
}

class DeleteStockException implements StonksException {
  final String _ticker;

  DeleteStockException({required String ticker}) : _ticker = ticker;

  @override
  String get message =>
      'Ошибка удаления $_ticker из списка отслеживаемых акций.';
}