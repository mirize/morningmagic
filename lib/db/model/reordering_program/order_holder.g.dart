// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_holder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderHolderAdapter extends TypeAdapter<OrderHolder> {
  @override
  final typeId = 201;

  @override
  OrderHolder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderHolder(
      (fields[0] as List)?.cast<OrderItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderHolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }
}
