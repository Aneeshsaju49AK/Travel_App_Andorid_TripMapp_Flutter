import 'package:hive/hive.dart';

part "user_model.g.dart";

@HiveType(typeId: 10)
class ProfileModels {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? userName;
  @HiveField(4)
  String? phone;
  @HiveField(5)
  String? profilePicturePath;

  ProfileModels({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
    required this.phone,
    this.profilePicturePath,
  });
}
