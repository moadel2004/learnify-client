// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeaturedModelAdapter extends TypeAdapter<FeaturedModel> {
  @override
  final int typeId = 0;

  @override
  FeaturedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeaturedModel(
      title: fields[0] as String,
      description: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
 void write(BinaryWriter writer, FeaturedModel obj) {
    writer
      ..writeByte(3) // Updated to 3 fields
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2) // Write the third field (image)
      ..write(obj.image); // Write the image field
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeaturedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
