// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lastname.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LastNameAdapter extends TypeAdapter<LastName> {
  @override
  final int typeId = 4;

  @override
  LastName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastName(
      uuid: fields[0] as String,
      lastname: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LastName obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.lastname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
