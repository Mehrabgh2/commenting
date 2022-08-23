// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 1;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      uuid: fields[0] as String,
      title: fields[1] as String,
      comment: fields[2] as String,
      author: fields[3] as String?,
      email: fields[4] as String?,
      rating: fields[5] as int?,
      quality: fields[6] as int?,
      price: fields[7] as int?,
      advantages: (fields[8] as List?)?.cast<String>(),
      disadvantage: (fields[9] as List?)?.cast<String>(),
      recommended: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.quality)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.advantages)
      ..writeByte(9)
      ..write(obj.disadvantage)
      ..writeByte(10)
      ..write(obj.recommended);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
