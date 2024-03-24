/* this widget is used for the main view in TabBar 
  also enable the listview builder
 */
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/maplocation_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/details_Screen.dart';

class TabBarListWidget extends StatefulWidget {
  final ValueNotifier<List<ModelPlace>> placeListNotifierCommon;
  const TabBarListWidget({required this.placeListNotifierCommon, Key? key})
      : super(key: key);

  @override
  State<TabBarListWidget> createState() => _TabBarListWidgetState();
}

class _TabBarListWidgetState extends State<TabBarListWidget> {
  List<bool> showFullText =
      List.filled(PlacesDB.instance.placeListNotifier.value.length, false);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<MapLocationProvider>(context);
    return ValueListenableBuilder<List<ModelPlace>>(
      valueListenable: PlacesDB.instance.placeListNotifier,
      builder: (context, placeList, _) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: min(5, placeList.length),
          itemBuilder: (context, index) {
            ModelPlace place = placeList[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
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
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: 170,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.green,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.antiAlias,
                      children: [
                        place.images![0].startsWith("asset/")
                            ? Image.asset(
                                place.images![0],
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.high,
                              )
                            : Image.file(
                                File(place.images![0]),
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.high,
                              ),
                        // this container is used to set a opacity for image to prevent unreadablty
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),

                        Positioned(
                          left: 10,
                          top: 140,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showFullText[index] = !showFullText[index];
                              });
                            },
                            child: Container(
                              child: placeList[index].placeName != null
                                  ? FittedBox(
                                      child: Text(
                                        placeList[index].placeName!.length <= 8
                                            ? "${placeList[index].placeName}"
                                            : showFullText[index]
                                                ? "${placeList[index].placeName}"
                                                : "${placeList[index].placeName!.substring(0, 6)}...",
                                        style: GoogleFonts.abel(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text("placeName"),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 165,
                          child: Text(
                            place.subPlaceName ?? "district",
                            style: GoogleFonts.abel(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
