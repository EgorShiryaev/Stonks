import 'package:hive/hive.dart';
part 'stock_entity.g.dart';

@HiveType(typeId: 0)
class StockEntity {
  /// Тикер
  @HiveField(0)
  final String ticker;

  /// Полное название
  @HiveField(1)
  final String title;

  /// Цена (указана в центах)
  @HiveField(2)
  int price;

  StockEntity({
    required this.ticker,
    required this.title,
    required this.price,
  });

  void updatePrice(int newPrice) => price = newPrice;
}
