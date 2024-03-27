/*in this widget is try to acheive the add favorite list according to the value */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/maplocation_page_provider/maplocation_provider.dart';

class HeartButtonWidget extends StatelessWidget {
  final double sizeOfImage;
  final ModelPlace place;
  final Function(ModelPlace)? onFavoriteTapped;
  final bool isFavorite;

  const HeartButtonWidget({
    required this.sizeOfImage,
    required this.place,
    required this.isFavorite,
    this.onFavoriteTapped,
    Key? key,
  }) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<MapLocationProvider>(context);
    auth.initValue(place);
    auth.currentPlace;

    auth.checkIsFavorite(isFavorite);
    return GestureDetector(
      onTap: () async {
        if (auth.isFavorite) {
          await FavoritesDB.instance.removeFavorite(auth.currentPlace);
        } else {
          await FavoritesDB.instance.addFavorite(auth.currentPlace);
        }
        onFavoriteTapped?.call(auth.currentPlace);
        FavoritesDB.instance.updateFavoriteList();
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          auth.isFavorite ? Colors.red : Colors.grey,
          BlendMode.srcIn,
        ),
        child: Image.asset(
          "asset/imges/heart-in-a-circle.png",
          width: sizeOfImage,
        ),
      ),
    );
  }
}
