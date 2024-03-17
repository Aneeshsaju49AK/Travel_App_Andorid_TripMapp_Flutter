import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';

const PROFILE_DB_NAME = 'profile-database';

abstract class ProfileDbFunctions {
  Future<List<ProfileModel>> getProfile();
  Future<void> insertProfile(ProfileModel value);
  Future<void> updateProfile(ProfileModel updatedPlace);
}

class ProfileDB implements ProfileDbFunctions {
  ProfileDB._internal();

  static ProfileDB instance = ProfileDB._internal();
  factory ProfileDB() {
    return instance;
  }
  static ValueNotifier<List<ProfileModel>> userListNotifier = ValueNotifier([]);

  @override
  Future<List<ProfileModel>> getProfile() async {
    final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
    return profileDB.values.toList();
  }

  @override
  Future<void> insertProfile(ProfileModel value) async {
    final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
    await profileDB.add(value);
  }

  @override
  Future<void> updateProfile(ProfileModel updatedPlace) async {
    final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
    final placeIndex = profileDB.values
        .toList()
        .indexWhere((element) => element.id == updatedPlace.id);

    if (placeIndex != -1) {
      await profileDB.putAt(placeIndex, updatedPlace);
      await reFreshUI();
    }
  }

  Future<void> reFreshUI() async {
    final allProfile = await getProfile();
    userListNotifier.value.clear();
    await Future.forEach(allProfile, (ProfileModel element) {
      userListNotifier.value.add(element);
    });
    userListNotifier.notifyListeners();
  }
}
