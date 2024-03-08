import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class TypePlaceScreen extends StatelessWidget {
  final ValueNotifier<List<ModelPlace>> placeListNotifierTypePlace;
  const TypePlaceScreen({required this.placeListNotifierTypePlace, Key? key})
      : super(key: key);

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
                const SearchWidget(
                  isNavigation: false,
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  width: width / 1,
                  height: height / 1.5,
                  child: PopularListViewWidget(
                      placeListNotifierPopular: placeListNotifierTypePlace),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
