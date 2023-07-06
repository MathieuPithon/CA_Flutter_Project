// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 0;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<String>(),
      fields[4] as String,
      fields[5] as String,
      fields[6] as num,
      fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.photoPath)
      ..writeByte(4)
      ..write(obj.commentary)
      ..writeByte(5)
      ..write(obj.wheater)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
