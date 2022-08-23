// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sended_comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SendedCommentAdapter extends TypeAdapter<SendedComment> {
  @override
  final int typeId = 2;

  @override
  SendedComment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SendedComment(
      uuid: fields[0] as String,
      comment: fields[1] as Comment,
      product: fields[2] as Product,
      time: fields[3] as num,
      isSuccess: fields[4] as bool,
      message: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SendedComment obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.isSuccess)
      ..writeByte(5)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SendedCommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
