import 'package:hive/hive.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
part 'addTrip_model.g.dart';

@HiveType(typeId: 4)
class TripModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  DateTime? startDate;
  @HiveField(3)
  DateTime? endDate;
  @HiveField(4)
  ModelPlace? selectedPlace;

  TripModel({
    this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.selectedPlace,
  });
}
