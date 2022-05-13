import 'package:hive/hive.dart';
import '../../domain/entity/stock_entity.dart';

class FollowStockAdapter extends TypeAdapter<StockEntity> {
  @override
  int get typeId => 0;

  @override
  StockEntity read(BinaryReader reader) {
    final ticket = reader.readString();
    final title = reader.readString();
    final price = reader.readInt();
    return StockEntity(
      ticker: ticket,
      price: price,
      title: title,
    );
  }

  @override
  void write(BinaryWriter writer, StockEntity obj) {
    writer.writeString(obj.ticker);
    writer.writeString(obj.title);
    writer.writeInt(obj.price);
  }
}
