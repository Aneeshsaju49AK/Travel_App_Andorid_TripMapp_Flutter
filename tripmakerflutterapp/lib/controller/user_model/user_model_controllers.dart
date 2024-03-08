import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';

ValueNotifier<List<ProfileModel>> userListNotifier = ValueNotifier([]);

Future<void> addValue(ProfileModel value) async {
  final dataBase = await Hive.openBox("user_profile_type2");
  dataBase.add(value);
  await getUserValue();
}

Future<void> getUserValue() async {
  final dataBase = await Hive.openBox("user_profile_type2");
  final userList = dataBase.values.cast<ProfileModel>().toList();

  userListNotifier.value = userList;
  userListNotifier.notifyListeners();
}
