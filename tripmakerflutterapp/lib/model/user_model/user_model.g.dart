// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelsAdapter extends TypeAdapter<ProfileModels> {
  @override
  final int typeId = 10;

  @override
  ProfileModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModels(
      id: fields[0] as int?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      userName: fields[3] as String?,
      phone: fields[4] as String?,
      profilePicturePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModels obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.profilePicturePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
