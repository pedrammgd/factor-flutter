// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'factor_view_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactorHomeViewModelHiveAdapter
    extends TypeAdapter<FactorHomeViewModelHive> {
  @override
  final int typeId = 1;

  @override
  FactorHomeViewModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FactorHomeViewModelHive(
      id: fields[0] as String?,
      uint8ListPdf: fields[1] as String?,
      titleFactor: fields[2] as String?,
      dateFactor: fields[3] as String?,
      numFactor: fields[4] as String?,
      totalPrice: fields[6] as double?,
      currencyType: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FactorHomeViewModelHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uint8ListPdf)
      ..writeByte(2)
      ..write(obj.titleFactor)
      ..writeByte(3)
      ..write(obj.dateFactor)
      ..writeByte(4)
      ..write(obj.numFactor)
      ..writeByte(5)
      ..write(obj.currencyType)
      ..writeByte(6)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactorHomeViewModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
