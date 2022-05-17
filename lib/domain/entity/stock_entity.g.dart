// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockEntityAdapter extends TypeAdapter<StockEntity> {
  @override
  final int typeId = 0;

  @override
  StockEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockEntity(
      ticker: fields[0] as String,
      title: fields[1] as String,
      price: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StockEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.ticker)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
