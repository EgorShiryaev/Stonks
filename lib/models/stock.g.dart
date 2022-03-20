// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockAdapter extends TypeAdapter<Stock> {
  @override
  final int typeId = 0;

  @override
  Stock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stock(
      prefix: fields[0] as String,
      lastPrice: fields[1] as double,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Stock obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.prefix)
      ..writeByte(1)
      ..write(obj.lastPrice)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
