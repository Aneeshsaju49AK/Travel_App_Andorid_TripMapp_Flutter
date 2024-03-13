import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';

import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/details_Screen.dart';

import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String searchQuery = "";

  late ModelPlace currentPlace;
  bool isFavorite = true;
  ValueNotifier<List<ModelPlace>> filteredList = ValueNotifier([]);

  @override
  void initState() {
    FavoritesDB.instance.updateFavoriteList();
  }

  Future<void> _toggleFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      prefs.setBool('isFavorite_${currentPlace.id}', isFavorite);
    });
  }

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width / 1,
            height: height / 1,
            child: Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 45,
                        left: 12,
                      ),
                      child: BackButtonWidget(
                        sizeOfImage: 40,
                        isCHecked: true,
                      ),
                    ),
                    HeadWritingWidget(
                      label: "Favorites",
                      divideHeight: 9,
                      divideWidth: 1.2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SearchWidget(
                  isNavigation: false,
                  onSearch: handleSearch,
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  width: width / 1,
                  height: height / 1.5,
                  child: ValueListenableBuilder(
                    valueListenable: filteredList,
                    builder: (context, valueList, _) {
                      print(valueList.length);
                      return ListView.builder(
                        itemCount: valueList.length,
                        itemBuilder: (context, index) {
                          ModelPlace place = valueList[index];
                          currentPlace = valueList[index];
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: width / 1,
                              height: height / 3.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        place: place,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: width / 1,
                                      height: height / 3.5,
                                      child: getImageWidget(
                                        place.images![0],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    Positioned(
                                      left: width / 1.3,
                                      top: height / 20,
                                      child: HeartButtonWidget(
                                        sizeOfImage: 30,
                                        place: place,
                                        isFavorite: isFavorite,
                                        onFavoriteTapped: (isFavorite) {
                                          FavoritesDB.instance
                                              .removeFavorite(place);
                                          _toggleFavoriteStatus();
                                          setState(() {
                                            FavoritePage();
                                          });
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: height / 5,
                                      left: width / 20,
                                      child: SizedBox(
                                        width: width / 1.5,
                                        height: height / 25,
                                        child: FittedBox(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            place.placeName!,
                                            style: GoogleFonts.abel(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleSearch(String searchText) {
    searchQuery = searchText;

    final placeList = FavoritesDB.favoriteListNotifier.value;

    print(placeList.length);
    print(searchText);

    if (searchText.isEmpty) {
      filteredList.value = placeList;
    } else {
      List<ModelPlace> filteredPlaces = placeList
          .where(
            (element) => element.placeName!.toLowerCase().contains(
                  searchText.toLowerCase(),
                ),
          )
          .toList();
      filteredList.value = filteredPlaces;
    }
  }

  Widget getImageWidget(String imagePath) {
    if (imagePath.startsWith("assets/")) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    }
  }
}
