import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late ModelPlace currentPlace;
  bool isFavorite = true;

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
                      label: "Category",
                      divideHeight: 9,
                      divideWidth: 1.2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const SearchWidget(
                  isNavigation: false,
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  width: width / 1,
                  height: height / 1.5,
                  child: ValueListenableBuilder(
                    valueListenable: PlacesDB.favoriteListNotifier,
                    builder: (context, valueList, _) {
                      return ListView.builder(
                        itemCount: valueList.length,
                        itemBuilder: (context, index) {
                          ModelPlace place = valueList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: width / 1,
                              height: height / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: width / 1,
                                    height: height / 3.5,
                                    child: getImageWidget(
                                      place.images![0],
                                    ),
                                  ),
                                  HeartButtonWidget(
                                    sizeOfImage: 30,
                                    place: place,
                                    isFavorite: isFavorite,
                                    onFavoriteTapped: (isFavorite) {
                                      PlacesDB.favoriteListNotifier.value
                                          .remove(place);
                                      setState(() {
                                        FavoritePage();
                                      });
                                    },
                                  ),
                                ],
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
