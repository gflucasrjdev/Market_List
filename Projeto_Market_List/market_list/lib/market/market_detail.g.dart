// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarketDetailAdapter extends TypeAdapter<MarketDetail> {
  @override
  final int typeId = 3;

  @override
  MarketDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarketDetail(
      storeName: fields[0] as String,
      listName: fields[1] as String,
      value: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MarketDetail obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.storeName)
      ..writeByte(1)
      ..write(obj.listName)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
