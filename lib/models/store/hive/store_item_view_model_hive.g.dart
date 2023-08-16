// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_item_view_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreItemViewModelHiveAdapter
    extends TypeAdapter<StoreItemViewModelHive> {
  @override
  final int typeId = 2;

  @override
  StoreItemViewModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreItemViewModelHive(
      id: fields[0] as String,
      productDescription: fields[1] as String,
      productCount: fields[2] as double,
      productUnitPrice: fields[3] as String,
      totalPriceItem: fields[5] as double,
      unitValue: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoreItemViewModelHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productDescription)
      ..writeByte(2)
      ..write(obj.productCount)
      ..writeByte(3)
      ..write(obj.productUnitPrice)
      ..writeByte(4)
      ..write(obj.unitValue)
      ..writeByte(5)
      ..write(obj.totalPriceItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreItemViewModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
