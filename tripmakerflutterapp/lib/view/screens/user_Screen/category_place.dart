import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class TypePlaceScreen extends StatefulWidget {
  final ValueNotifier<List<ModelPlace>> placeListNotifierTypePlace;
  const TypePlaceScreen({required this.placeListNotifierTypePlace, Key? key})
      : super(key: key);

  @override
  State<TypePlaceScreen> createState() => _TypePlaceScreenState();
}

class _TypePlaceScreenState extends State<TypePlaceScreen> {
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
                      label: "Category",
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
    final placeList = widget.placeListNotifierTypePlace.value;
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
}
