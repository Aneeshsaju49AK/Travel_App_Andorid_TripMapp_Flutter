import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripmakerflutterapp/model/addTrip_model/addTrip_model.dart';

const PLACELISTADDTRIP_DB_NAME = "addtrip-database-04";

abstract class AddTripDbFunctions {
  Future<List<TripModel>> getAddtrip();
  Future<void> insertAddtrip(TripModel value);
  Future<void> deleteAddtrip(String? id);
}

class AddtripDB implements AddTripDbFunctions {
  AddtripDB._internal();

  static AddtripDB instance = AddtripDB._internal();

  factory AddtripDB() {
    return instance;
  }

  ValueNotifier<List<TripModel>> planTripNotifier = ValueNotifier([]);
  @override
  Future<void> deleteAddtrip(String? id) async {
    final addtripDB = await Hive.openBox<TripModel>(PLACELISTADDTRIP_DB_NAME);
    final tripIndex = addtripDB.keys
        .toList()
        .indexWhere((key) => addtripDB.get(key)?.id == id);
    if (tripIndex != -1) {
      await addtripDB
          .deleteAt(tripIndex); // Delete the item at the specified index
    }
    await addtripDB.close();
    refreshListUI();
  }

  @override
  Future<List<TripModel>> getAddtrip() async {
    final addtripDB = await Hive.openBox<TripModel>(PLACELISTADDTRIP_DB_NAME);
    return addtripDB.values.toList();
  }

  @override
  Future<void> insertAddtrip(TripModel value) async {
    final addtripDB = await Hive.openBox<TripModel>(PLACELISTADDTRIP_DB_NAME);
    await addtripDB.add(value);

    refreshListUI();
  }

  Future<void> refreshListUI() async {
    final allListAdded = await getAddtrip();

    planTripNotifier.value.clear();

    await Future.forEach(allListAdded, (TripModel place) {
      planTripNotifier.value.add(place);
    });
    planTripNotifier.notifyListeners();
  }
}
