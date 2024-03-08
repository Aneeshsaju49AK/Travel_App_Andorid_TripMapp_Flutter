import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class DetailsScreen extends StatefulWidget {
  final ModelPlace place;

  const DetailsScreen({required this.place, Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late ModelPlace _currentPlace;
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPlace = widget.place;

    isFavorite = PlacesDB.favoriteListNotifier.value.contains(_currentPlace);
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
            height: height / .9,
            child: Stack(
              children: [
                SizedBox(
                  height: height / 2,
                  width: width / 1,
                  child: Stack(
                    children: [
                      SliderImageViewWidget(
                        imagePathList: _currentPlace.images!,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 12,
                          left: 20,
                        ),
                        child: BackButtonWidget(
                          sizeOfImage: 43,
                          isCHecked: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 290,
                          top: 15,
                        ),
                        child: HeartButtonWidget(
                          sizeOfImage: 45,
                          place: _currentPlace,
                          isFavorite: isFavorite,
                          onFavoriteTapped: (p0) {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 342,
                  ),
                  child: Container(
                    height: height / 1.5,
                    width: width / 1,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 236, 235, 235),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: width / 1,
                          height: height / 8,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  top: 22,
                                ),
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        "hi",
                                        style: GoogleFonts.abel(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "asset/imges/navigation_img/location.png",
                                            width: 15,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "hi",
                                            style: GoogleFonts.abel(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width / 1.8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Image.asset(
                                  "asset/imges/discount.png",
                                  width: 45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width / 1.2,
                          height: height / 11,
                          child: Row(
                            children: [
                              Container(
                                width: width / 3.6,
                                height: height / 11,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    top: 12,
                                  ),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Travel duration",
                                          style: GoogleFonts.abel(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "asset/imges/navigation_img/location.png",
                                              width: 13,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "hi",
                                              style: GoogleFonts.abel(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width / 3.6,
                                height: height / 11,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    top: 12,
                                  ),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rating",
                                          style: GoogleFonts.abel(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "asset/imges/navigation_img/location.png",
                                              width: 13,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              " 4*",
                                              style: GoogleFonts.abel(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width / 3.6,
                                height: height / 11,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    top: 12,
                                  ),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price",
                                          style: GoogleFonts.abel(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "asset/imges/navigation_img/location.png",
                                              width: 13,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _currentPlace.price!,
                                              style: GoogleFonts.abel(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width / 1.1,
                          height: height / 14,
                          child: Row(
                            children: [
                              Text(
                                "About",
                                style: GoogleFonts.abel(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: width / 1.8,
                              ),
                              Image.asset(
                                "asset/imges/navigation_img/eye.png",
                                width: 25,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Watch \nvlogs",
                                style: GoogleFonts.abel(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width / 1.2,
                          height: height / 4.5,
                          child: Text(
                            _currentPlace.description!,
                          ),
                        ),
                        ButtonCommonWidget(
                          label: "Plan you Trip",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
