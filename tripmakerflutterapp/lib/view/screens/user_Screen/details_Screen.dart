import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/blogs_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class DetailsScreen extends StatefulWidget {
  final ModelPlace place;

  const DetailsScreen({required this.place, Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool showFullDescription = false;
  late ModelPlace _currentPlace;
  bool isFavorite = false;
  bool showFullText = false;
  bool showFullTextsub = false;

  @override
  void initState() {
    super.initState();
    _currentPlace = widget.place;
    // setState(() {
    //   isFavorite =
    //       FavoritesDB.favoriteListNotifier.value.contains(_currentPlace);
    // });
    // _checkFavoriteStatus();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('isFavorite_${_currentPlace.id}') ?? false;
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      prefs.setBool('isFavorite_${_currentPlace.id}', isFavorite);
    });
  }
  // Future<void> _checkFavoriteStatus() async {
  //   bool isPlaceFavorite =
  //       await FavoritesDB.favoriteListNotifier.value.contains(_currentPlace);

  //   setState(() {
  //     isFavorite = isPlaceFavorite;
  //   });
  //   print("is $isPlaceFavorite");
  // }

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
                        padding: const EdgeInsets.only(
                          left: 290,
                          top: 15,
                        ),
                        child: HeartButtonWidget(
                          sizeOfImage: 45,
                          place: _currentPlace,
                          isFavorite: isFavorite,
                          onFavoriteTapped: (p0) {
                            _toggleFavoriteStatus();
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
                    decoration: BoxDecoration(
                      color: Provider.of<DarkModeProvider>(context).value
                          ? const Color.fromARGB(255, 33, 39, 43)
                          : const Color.fromARGB(255, 230, 234, 212),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: width / 1,
                          height: height / 8,
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  top: 22,
                                ),
                                child: SizedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: width / 2,
                                          height: height / 17,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                showFullText = !showFullText;
                                              });
                                            },
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: SizedBox(
                                                  child: Text(
                                                showFullText
                                                    ? "${_currentPlace.placeName}"
                                                    : "${_currentPlace.placeName!.substring(0, 9)}...",
                                                style: GoogleFonts.abel(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              )),
                                            ),
                                          )),
                                      SizedBox(
                                        height: height / 27,
                                        width: width / 1.4,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "asset/imges/navigation_img/location.png",
                                              width: 15,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: SizedBox(
                                                width: width / 2.6,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: FittedBox(
                                                    child: Text(
                                                      showFullText
                                                          ? "${_currentPlace.subPlaceName}"
                                                          : "${_currentPlace.subPlaceName!.substring(0, 7)}...",
                                                      style: GoogleFonts.abel(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: SizedBox(
                                  child: Image.asset(
                                    "asset/imges/discount.png",
                                    width: 45,
                                  ),
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  showFullTextsub =
                                                      !showFullTextsub;
                                                });
                                              },
                                              child: SizedBox(
                                                width: width / 5,
                                                height: height / 32,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: FittedBox(
                                                    child: Text(
                                                      showFullTextsub
                                                          ? "${_currentPlace.subPlaceName}"
                                                          : "${_currentPlace.subPlaceName!.substring(0, 9)}...",
                                                      style: GoogleFonts.abel(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BlogsScreenWidget(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Watch \nvlogs",
                                  style: GoogleFonts.abel(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showFullDescription = !showFullDescription;
                            });
                          },
                          child: SizedBox(
                            width: width / 1.2,
                            height: height / 4.7,
                            // height: showFullDescription
                            //     ? null
                            //     : MediaQuery.of(context).size.height / 4.5,
                            child: SingleChildScrollView(
                              child: Text(
                                _currentPlace.description!,
                                // maxLines: showFullDescription
                                //     ? null
                                //     : 12, // Show all lines if full text is displayed
                                // overflow: showFullDescription
                                //     ? TextOverflow.visible
                                //     : TextOverflow
                                //         .ellipsis, // Show ellipsis if text is truncated
                              ),
                            ),
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
