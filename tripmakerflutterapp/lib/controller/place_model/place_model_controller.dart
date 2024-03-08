import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

const PLACE_DB_NAME = 'place-database';

abstract class PlaceDbFunctions {
  Future<List<ModelPlace>> getPlaces();
  Future<void> insertPlaces(ModelPlace value);
  Future<void> deletePlaces(int id);
}

class PlacesDB implements PlaceDbFunctions {
  PlacesDB._internal();

  static PlacesDB instance = PlacesDB._internal();

  factory PlacesDB() {
    return instance;
  }
  static ValueNotifier<List<ModelPlace>> favoriteListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> placeListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> hillStationCatrgoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> momumentsCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> waterfallsCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> forestsCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> beachCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> desertsCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> alappuzhaListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> ernakulamListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> idukkiListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kannurListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kasargodeListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kollamListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kottayamListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kozhikodeListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> malappuramListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> palakkaduListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> pathanamthittaListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> trissurListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> trivanramListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> wayanadListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> commonDistrictListNotifier =
      ValueNotifier([]);

  @override
  Future<void> deletePlaces(int id) async {
    final placeDB = await Hive.openBox<ModelPlace>(PLACE_DB_NAME);
    await placeDB.delete(id);
  }

  @override
  Future<List<ModelPlace>> getPlaces() async {
    final placeDB = await Hive.openBox<ModelPlace>(PLACE_DB_NAME);
    return placeDB.values.toList();
  }

  @override
  Future<void> insertPlaces(ModelPlace value) async {
    final placesDB = await Hive.openBox<ModelPlace>(PLACE_DB_NAME);
    await placesDB.add(value);
  }

  Future<void> reFreshUI() async {
    final allPlaces = await getPlaces();
    placeListNotifier.value.clear();
    hillStationCatrgoryListNotifier.value.clear();
    desertsCategoryNotifier.value.clear();
    forestsCategoryNotifier.value.clear();
    momumentsCategoryListNotifier.value.clear();
    waterfallsCategoryListNotifier.value.clear();
    beachCategoryNotifier.value.clear();
    await Future.forEach(
      allPlaces,
      (ModelPlace place) {
        placeListNotifier.value.add(place);
        if (place.category != null) {
          if (place.category == PlaceCategory.hillStations) {
            hillStationCatrgoryListNotifier.value.add(place);
          } else if (place.category == PlaceCategory.lake) {
            desertsCategoryNotifier.value.add(place);
          } else if (place.category == PlaceCategory.forests) {
            forestsCategoryNotifier.value.add(place);
          } else if (place.category == PlaceCategory.monuments) {
            momumentsCategoryListNotifier.value.add(place);
          } else if (place.category == PlaceCategory.waterfalls) {
            waterfallsCategoryListNotifier.value.add(place);
          } else if (place.category == PlaceCategory.beaches) {
            beachCategoryNotifier.value.add(place);
          }
        }
      },
    );
    placeListNotifier.notifyListeners();
    hillStationCatrgoryListNotifier.notifyListeners();
    desertsCategoryNotifier.notifyListeners();
    forestsCategoryNotifier.notifyListeners();
    momumentsCategoryListNotifier.notifyListeners();
    waterfallsCategoryListNotifier.notifyListeners();
    beachCategoryNotifier.notifyListeners();

    alappuzhaListNotifier.value.clear();
    ernakulamListNotifier.value.clear();
    idukkiListNotifier.value.clear();
    kannurListNotifier.value.clear();
    kasargodeListNotifier.value.clear();
    kollamListNotifier.value.clear();
    kozhikodeListNotifier.value.clear();
    malappuramListNotifier.value.clear();
    palakkaduListNotifier.value.clear();
    pathanamthittaListNotifier.value.clear();
    trissurListNotifier.value.clear();
    trivanramListNotifier.value.clear();
    wayanadListNotifier.value.clear();
    commonDistrictListNotifier.value.clear();
    await Future.forEach(
      allPlaces,
      (ModelPlace place) {
        if (place.district == District.Alappuzha) {
          alappuzhaListNotifier.value.add(place);
        } else if (place.district == District.Ernakulam) {
          ernakulamListNotifier.value.add(place);
        } else if (place.district == District.Idukki) {
          idukkiListNotifier.value.add(place);
        } else if (place.district == District.Kannur) {
          kannurListNotifier.value.add(place);
        } else if (place.district == District.Kasargode) {
          kasargodeListNotifier.value.add(place);
        } else if (place.district == District.Kollam) {
          kollamListNotifier.value.add(place);
        } else if (place.district == District.Kottayam) {
          kottayamListNotifier.value.add(place);
        } else if (place.district == District.Kozhikode) {
          kozhikodeListNotifier.value.add(place);
        } else if (place.district == District.Malappuram) {
          malappuramListNotifier.value.add(place);
        } else if (place.district == District.Palakkadu) {
          palakkaduListNotifier.value.add(place);
        } else if (place.district == District.Pathanamthitta) {
          pathanamthittaListNotifier.value.add(place);
        } else if (place.district == District.Thrissur) {
          trissurListNotifier.value.add(place);
        } else if (place.district == District.Trivandram) {
          trivanramListNotifier.value.add(place);
        } else if (place.district == District.Wayanad) {
          wayanadListNotifier.value.add(place);
        } else {
          commonDistrictListNotifier.value.add(place);
        }
      },
    );
    alappuzhaListNotifier.notifyListeners();
    ernakulamListNotifier.notifyListeners();
    idukkiListNotifier.notifyListeners();
    kannurListNotifier.notifyListeners();
    kasargodeListNotifier.notifyListeners();
    kollamListNotifier.notifyListeners();
    kottayamListNotifier.notifyListeners();
    kozhikodeListNotifier.notifyListeners();
    malappuramListNotifier.notifyListeners();
    palakkaduListNotifier.notifyListeners();
    pathanamthittaListNotifier.notifyListeners();
    trissurListNotifier.notifyListeners();
    wayanadListNotifier.notifyListeners();
    trivanramListNotifier.notifyListeners();
    commonDistrictListNotifier.notifyListeners();
  }
}
