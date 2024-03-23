import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';

const PROFILE_DB_NAME = 'profile-database-01';

abstract class ProfileDbFunctions {
  Future<List<ProfileModels>> getProfileAll();
  Future<void> insertProfile(ProfileModels value);
  Future<void> updateProfile(ProfileModels updatedPlace);
}

class ProfileDB implements ProfileDbFunctions {
  ProfileDB._internal();

  static ProfileDB instance = ProfileDB._internal();
  factory ProfileDB() {
    return instance;
  }
  static ValueNotifier<List<ProfileModels>> userListNotifier =
      ValueNotifier([]);

  @override
  Future<List<ProfileModels>> getProfileAll() async {
    final profileDB = await Hive.openBox<ProfileModels>(PROFILE_DB_NAME);
    return profileDB.values.toList();
  }

  @override
  Future<void> insertProfile(ProfileModels value) async {
    final profileDB = await Hive.openBox<ProfileModels>(PROFILE_DB_NAME);
    await profileDB.add(value);
  }

  @override
  Future<void> updateProfile(ProfileModels updatedPlace) async {
    final profileDB = await Hive.openBox<ProfileModels>(PROFILE_DB_NAME);
    final placeIndex = profileDB.values
        .toList()
        .indexWhere((element) => element.id == updatedPlace.id);

    if (placeIndex != -1) {
      await profileDB.putAt(placeIndex, updatedPlace);
      await reFreshUIProfile();
    }
  }

  Future<void> reFreshUIProfile() async {
    final allProfile = await getProfileAll();
    userListNotifier.value.clear();
    await Future.forEach(allProfile, (ProfileModels element) {
      userListNotifier.value.add(element);
    });
    userListNotifier.notifyListeners();
  }
}
