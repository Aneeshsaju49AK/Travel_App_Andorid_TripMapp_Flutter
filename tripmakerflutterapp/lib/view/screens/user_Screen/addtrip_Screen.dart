import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/headWwite_widget/headwrite_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/search_folder/search_widget.dart';

import '../../widget/common_widget/populatList_folder/commonwidget.dart';

class AddTripScreen extends StatelessWidget {
  final void Function(ModelPlace)? onPlace;
  AddTripScreen({this.onPlace, super.key});

  String searchQuery = "";

  ValueNotifier<List<ModelPlace>> filteredList = ValueNotifier([]);

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
                        isCHecked: false,
                      ),
                    ),
                    HeadWritingWidget(
                      label: "search",
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
                  child: PopularListViewWidget(
                    placeListNotifierPopular: filteredList,
                    onPlaceSelected: (selectedPlace) {
                      // Handle the selected place here
                      onPlace?.call(selectedPlace);
                      // print("Selected place: ${selectedPlace.placeName}");
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

    final placeList = PlacesDB.instance.placeListNotifier.value;

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

    // You can perform any other actions based on the search text
  }
}
