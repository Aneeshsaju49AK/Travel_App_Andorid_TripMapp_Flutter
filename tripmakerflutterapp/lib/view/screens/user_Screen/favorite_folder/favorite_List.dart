import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/favorite_page_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/details_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/headWwite_widget/headwrite_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/heartButton_folder/heartbutton_widget.dart';

import '../../widget/common_widget/populatList_folder/commonwidget.dart';
import '../../widget/common_widget/search_folder/search_widget.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  String searchQuery = "";

  late ModelPlace currentPlace;

  // bool isFavorite = true;
  ValueNotifier<List<ModelPlace>> filteredList = ValueNotifier([]);

  // @override

  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteButton>(context).callRefreshUi;
    // Provider.of<FavoriteButton>(context).loadFavoriteStatus(currentPlace);
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
                Row(
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
                    valueListenable: searchQuery == ""
                        ? FavoritesDB.favoriteListNotifier
                        : filteredList,
                    builder: (context, valueList, _) {
                      return ListView.builder(
                        itemCount: valueList.length,
                        itemBuilder: (context, index) {
                          ModelPlace place = valueList[index];
                          currentPlace = valueList[index];
                          Provider.of<FavoriteButton>(context)
                              .loadFavoriteStatus(currentPlace);

                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: width / 1,
                              height: height / 3.5,
                              decoration: const BoxDecoration(
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
                                      child:
                                          Provider.of<CommonProvider>(context)
                                              .getImageWidgetUrl(
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
                                      child: Consumer<FavoriteButton>(
                                        builder: (context, value, child) {
                                          return HeartButtonWidget(
                                            sizeOfImage: 30,
                                            place: place,
                                            isFavorite: value.isFavorite,
                                            onFavoriteTapped: (isFavorite) {
                                              final currentIndex = filteredList
                                                  .value
                                                  .indexWhere((element) =>
                                                      element == place);
                                              if (currentIndex != -1) {
                                                filteredList.value
                                                    .removeAt(currentIndex);
                                              }

                                              value.setFavoriteStatus(
                                                  currentPlace);
                                            },
                                          );
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
