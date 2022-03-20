import 'package:hive/hive.dart';

import '../models/stock.dart';

class StockAdapter extends TypeAdapter<Stock> {
  @override
  int get typeId => 0;

  @override
  Stock read(BinaryReader reader) {
    final prefix = reader.readString();
    final lastPrice = reader.readDouble();
    final description = reader.readString();
    return Stock(
      prefix: prefix,
      lastPrice: lastPrice,
      description: description,
    );
  }

  @override
  void write(BinaryWriter writer, Stock obj) {
    writer.writeString(obj.prefix);
    writer.writeDouble(obj.lastPrice);
    writer.writeString(obj.description);
  }
}
