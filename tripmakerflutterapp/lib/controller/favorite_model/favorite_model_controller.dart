import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class FavoritesDB {
  static const String FAVORITE_DB_NAME = "favorites_DB-01";

  static final FavoritesDB instance = FavoritesDB._internal();

  factory FavoritesDB() {
    return instance;
  }

  FavoritesDB._internal();

  static final ValueNotifier<List<ModelPlace>> favoriteListNotifier =
      ValueNotifier<List<ModelPlace>>([]);

  Future<void> addFavorite(ModelPlace place) async {
    final favBox = await Hive.openBox<ModelPlace>(FAVORITE_DB_NAME);
    await favBox.put(place.id, place);
    updateFavoriteList();
  }

  Future<void> removeFavorite(ModelPlace place) async {
    final favBox = await Hive.openBox<ModelPlace>(FAVORITE_DB_NAME);
    await favBox.delete(place.id);
    updateFavoriteList();
  }

  Future<List<ModelPlace>> getFavorites() async {
    final favBox = await Hive.openBox<ModelPlace>(FAVORITE_DB_NAME);
    return favBox.values.toList();
  }

  Future<void> updateFavoriteList() async {
    final allFavorites = await getFavorites();
    favoriteListNotifier.value = allFavorites;
  }
}
