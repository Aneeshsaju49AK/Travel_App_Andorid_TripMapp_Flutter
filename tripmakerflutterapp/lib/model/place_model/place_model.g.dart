// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelPlaceAdapter extends TypeAdapter<ModelPlace> {
  @override
  final int typeId = 1;

  @override
  ModelPlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelPlace(
      id: fields[0] as String?,
      images: (fields[1] as List?)?.cast<String>(),
      district: fields[2] as District?,
      category: fields[3] as PlaceCategory?,
      placeName: fields[4] as String?,
      subPlaceName: fields[5] as String?,
      price: fields[6] as String?,
      durations: fields[7] as String?,
      description: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelPlace obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.district)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.placeName)
      ..writeByte(5)
      ..write(obj.subPlaceName)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.durations)
      ..writeByte(8)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelPlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DistrictAdapter extends TypeAdapter<District> {
  @override
  final int typeId = 3;

  @override
  District read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return District.Alappuzha;
      case 1:
        return District.Ernakulam;
      case 2:
        return District.Idukki;
      case 3:
        return District.Kannur;
      case 4:
        return District.Kasargode;
      case 5:
        return District.Kollam;
      case 6:
        return District.Kottayam;
      case 7:
        return District.Kozhikode;
      case 8:
        return District.Malappuram;
      case 9:
        return District.Palakkadu;
      case 10:
        return District.Pathanamthitta;
      case 11:
        return District.Thrissur;
      case 12:
        return District.Trivandram;
      case 13:
        return District.Wayanad;
      default:
        return District.Alappuzha;
    }
  }

  @override
  void write(BinaryWriter writer, District obj) {
    switch (obj) {
      case District.Alappuzha:
        writer.writeByte(0);
        break;
      case District.Ernakulam:
        writer.writeByte(1);
        break;
      case District.Idukki:
        writer.writeByte(2);
        break;
      case District.Kannur:
        writer.writeByte(3);
        break;
      case District.Kasargode:
        writer.writeByte(4);
        break;
      case District.Kollam:
        writer.writeByte(5);
        break;
      case District.Kottayam:
        writer.writeByte(6);
        break;
      case District.Kozhikode:
        writer.writeByte(7);
        break;
      case District.Malappuram:
        writer.writeByte(8);
        break;
      case District.Palakkadu:
        writer.writeByte(9);
        break;
      case District.Pathanamthitta:
        writer.writeByte(10);
        break;
      case District.Thrissur:
        writer.writeByte(11);
        break;
      case District.Trivandram:
        writer.writeByte(12);
        break;
      case District.Wayanad:
        writer.writeByte(13);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistrictAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlaceCategoryAdapter extends TypeAdapter<PlaceCategory> {
  @override
  final int typeId = 2;

  @override
  PlaceCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlaceCategory.hillStations;
      case 1:
        return PlaceCategory.monuments;
      case 2:
        return PlaceCategory.waterfalls;
      case 3:
        return PlaceCategory.forests;
      case 4:
        return PlaceCategory.beaches;
      case 5:
        return PlaceCategory.lake;
      default:
        return PlaceCategory.hillStations;
    }
  }

  @override
  void write(BinaryWriter writer, PlaceCategory obj) {
    switch (obj) {
      case PlaceCategory.hillStations:
        writer.writeByte(0);
        break;
      case PlaceCategory.monuments:
        writer.writeByte(1);
        break;
      case PlaceCategory.waterfalls:
        writer.writeByte(2);
        break;
      case PlaceCategory.forests:
        writer.writeByte(3);
        break;
      case PlaceCategory.beaches:
        writer.writeByte(4);
        break;
      case PlaceCategory.lake:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
