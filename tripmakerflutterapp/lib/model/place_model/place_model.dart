import 'package:hive/hive.dart';

part 'place_model.g.dart';

@HiveType(typeId: 3)
enum District {
  @HiveField(0)
  Alappuzha,
  @HiveField(1)
  Ernakulam,
  @HiveField(2)
  Idukki,
  @HiveField(3)
  Kannur,
  @HiveField(4)
  Kasargode,
  @HiveField(5)
  Kollam,
  @HiveField(6)
  Kottayam,
  @HiveField(7)
  Kozhikode,
  @HiveField(8)
  Malappuram,
  @HiveField(9)
  Palakkadu,
  @HiveField(10)
  Pathanamthitta,

  @HiveField(11)
  Thrissur,
  @HiveField(12)
  Trivandram,
  @HiveField(13)
  Wayanad,
  // Add more districts as needed
}

@HiveType(typeId: 2)
enum PlaceCategory {
  @HiveField(0)
  hillStations,
  @HiveField(1)
  monuments,
  @HiveField(2)
  waterfalls,
  @HiveField(3)
  forests,
  @HiveField(4)
  beaches,
  @HiveField(5)
  lake,
}

@HiveType(typeId: 1)
class ModelPlace {
  @HiveField(0)
  String? id;
  @HiveField(1)
  List<String>? images;
  @HiveField(2)
  District? district;
  @HiveField(3)
  PlaceCategory? category;
  @HiveField(4)
  String? placeName;
  @HiveField(5)
  String? subPlaceName;
  @HiveField(6)
  String? price;
  @HiveField(7)
  String? durations;
  @HiveField(8)
  String? description;

  ModelPlace({
    this.id,
    this.images,
    required this.district,
    required this.category,
    required this.placeName,
    required this.subPlaceName,
    required this.price,
    required this.durations,
    required this.description,
  });
}
