import 'package:hive/hive.dart';
part 'stock.g.dart';

@HiveType(typeId: 0)
class Stock {
  @HiveField(0)
  final String prefix;
  @HiveField(1)
   double lastPrice;
  @HiveField(2)
  final String description;

  Stock({
    required this.prefix,
    required this.lastPrice,
    required this.description,
  });

  updateLastPrice(String newPrice) => lastPrice = double.parse(newPrice);
}
