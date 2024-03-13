import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';

import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';

import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/category_place.dart';

import 'package:tripmakerflutterapp/view/screens/user_Screen/details_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';

/*this widget is mainly used to write the head of 

  signup and login page head */

class HeadWritingWidget extends StatelessWidget {
  final String label;
  final double? divideWidth;
  final double? divideHeight;
  const HeadWritingWidget({
    Key? key,
    required this.label,
    this.divideHeight,
    this.divideWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width / divideWidth!,
      height: height / divideHeight!,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          top: 50,
        ),
        child: Text(
          label,
          style: GoogleFonts.abel(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/*this widget is used for create textfield for
signup/ and  login page */

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;

  final TextEditingController? controller;
  final TextInputType keyboardType;
  const TextFieldWidget({
    Key? key,
    required this.label,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late TextEditingController _controller;
  bool showError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width / 1,
      height: showError ? height / 6 : height / 7,
      child: Column(
        children: [
          SizedBox(
            width: width / 1,
            height: height / 23,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.label,
                style: GoogleFonts.abel(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: width / 1.1,
              height: height / 13,
              child: TextFormField(
                keyboardType: widget.keyboardType,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: widget.validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*so this widget is made for button that can 
reuse in signup and login */
class ButtonCommonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ButtonCommonWidget({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
        width: width / 1.3,
        height: height / 13,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(120),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              label,
            ),
          ),
        ),
      ),
    );
  }
}

class MapLocation extends StatefulWidget {
  final bool? islocationWidget;
  final Position? location;
  final String? locationName;
  const MapLocation({
    this.islocationWidget,
    this.location,
    this.locationName,
    Key? key,
  }) : super(key: key);

  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showFullText = !showFullText;
        });
      },
      child: Container(
        child: widget.islocationWidget == true && widget.location != null
            ? Text(
                showFullText
                    ? "${widget.locationName}"
                    : "${widget.locationName!.substring(0, 10)}...", // Display only the first 10 characters
              )
            : Text("Location not available"),
      ),
    );
  }
}

/*this circle avatar is created to reuse the widget with in home 
drawer */
class CircleAvatarWidget extends StatelessWidget {
  final double radius;
  final String? imagePath;
  final bool? islocationwidget;
  final Position? location;
  final String? locationName;

  final VoidCallback? onpressed;
  const CircleAvatarWidget({
    required this.radius,
    this.location,
    this.locationName,
    this.onpressed,
    this.imagePath,
    this.islocationwidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onpressed,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
        child: islocationwidget == true
            ? imagePath == null
                ? Image.asset(
                    "asset/imges/navigation_img/home-icon-silhouette.png",
                    width: 20,
                  )
                : null
            : location != null
                ? Text("$locationName")
                : const Text("Location not available"),
      ),
    );
  }
}

/*this widet is used to build the search bar
maimly in the home and search page */
class SearchWidget extends StatefulWidget {
  final bool isNavigation;
  final void Function(String)? onSearch;

  const SearchWidget({
    required this.isNavigation,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
  void updateSearchText(String searchText) {
    // Call the provided callback function to send the value
    if (onSearch != null) {
      onSearch!(searchText);
    }
  }
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      // Call the callback function with the current text value
      widget.updateSearchText(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 0,
        ),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: 'Search for the Destinations',
            prefixIcon: IconButton(
              onPressed: () {
                if (widget.isNavigation == true) {
                  ScreenSelection.selectedIndexNotifier.value = 1;
                }
              },
              icon: const Icon(Icons.search),
            ),
            suffixIcon: const Icon(
              Icons.file_copy,
            ),
          ),
        ),
      ),
    );
  }
}

/* this Widget is create to have the Tabbar
in homepage */
class TabViewWidget extends StatefulWidget {
  const TabViewWidget({super.key});

  @override
  State<TabViewWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: SizedBox(
            width: width / 1,
            height: height / 19,
            child: TabBar(
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Most Popular',
                ),
                Tab(
                  text: 'Recommended',
                ),
                Tab(
                  text: 'Trending',
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: width / 1,
            height: height / 3.5,
            child: TabBarView(
              controller: _tabController,
              children: [
                SizedBox(
                  child: TabBarListWidget(
                    placeListNotifierCommon:
                        PlacesDB.instance.placeListNotifier,
                  ),
                ),
                SizedBox(
                  child: TabBarListWidget(
                    placeListNotifierCommon:
                        PlacesDB.instance.beachCategoryNotifier,
                  ),
                ),
                SizedBox(
                  child: TabBarListWidget(
                    placeListNotifierCommon:
                        PlacesDB.instance.alappuzhaListNotifier,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

/* this widget is used for the main view in TabBar 
  also enable the listview builder
 */
class TabBarListWidget extends StatefulWidget {
  final ValueNotifier<List<ModelPlace>> placeListNotifierCommon;
  const TabBarListWidget({required this.placeListNotifierCommon, Key? key})
      : super(key: key);

  @override
  State<TabBarListWidget> createState() => _TabBarListWidgetState();
}

class _TabBarListWidgetState extends State<TabBarListWidget> {
  bool showFullText = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ModelPlace>>(
      valueListenable: widget.placeListNotifierCommon,
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
                    gradient: LinearGradient(
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
                              )
                            : Image.file(
                                File(place.images![0]),
                                fit: BoxFit.fill,
                              ),
                        // this container is used to set a opacity for image to prevent unreadablty
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
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
                                showFullText = !showFullText;
                              });
                            },
                            child: Container(
                              child: place.placeName != null
                                  ? FittedBox(
                                      child: Text(
                                        showFullText
                                            ? "${place.placeName}"
                                            : "${place.placeName!.substring(0, 9)}...",
                                        style: GoogleFonts.abel(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text("placeName"),
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

/* the sildeViewWidget is created to use
in home page and tripplan page */

class SilderViewWidget extends StatelessWidget {
  SilderViewWidget({super.key});

  final List<CategoryDataOption> categories = [
    CategoryDataOption(
      title: "Hill Stations",
      imagePath: "asset/imges/categies_img/pexels-mikhail-nilov-8321369.jpg",
      placeListNotifierSilderWidget:
          PlacesDB.instance.hillStationCatrgoryListNotifier,
    ),
    CategoryDataOption(
      title: "Monuments",
      imagePath: "asset/imges/categies_img/pexels-setu-chhaya-9455189.jpg",
      placeListNotifierSilderWidget:
          PlacesDB.instance.momumentsCategoryListNotifier,
    ),
    CategoryDataOption(
      title: "Waterfalls",
      imagePath: "asset/imges/categies_img/pexels-aleksey-kuprikov-3715436.jpg",
      placeListNotifierSilderWidget:
          PlacesDB.instance.waterfallsCategoryListNotifier,
    ),
    CategoryDataOption(
      title: "Forests",
      imagePath: "asset/imges/categies_img/pexels-veeterzy-38136.jpg",
      placeListNotifierSilderWidget: PlacesDB.instance.forestsCategoryNotifier,
    ),
    CategoryDataOption(
      title: "Beaches",
      imagePath:
          "asset/imges/categies_img/pexels-asad-photo-maldives-1450372.jpg",
      placeListNotifierSilderWidget: PlacesDB.instance.beachCategoryNotifier,
    ),
    CategoryDataOption(
      title: "Deserts",
      imagePath: "asset/imges/categies_img/pexels-denys-gromov-13252308.jpg",
      placeListNotifierSilderWidget: PlacesDB.instance.desertsCategoryNotifier,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return CarouselSlider.builder(
          itemCount: categories.length,
          itemBuilder: (context, index, realIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TypePlaceScreen(
                      placeListNotifierTypePlace:
                          categories[index].placeListNotifierSilderWidget,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(
                          categories[index].imagePath,
                        ),
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.green,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // this container is used to set a opacity for image to prevent unreadablty
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 10,
                    child: Text(
                      categories[index].title,
                      style: GoogleFonts.abel(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 190,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        );
      },
    );
  }
}

class CategoryDataOption {
  final String title;
  final String imagePath;
  final ValueNotifier<List<ModelPlace>> placeListNotifierSilderWidget;

  CategoryDataOption(
      {required this.title,
      required this.imagePath,
      required this.placeListNotifierSilderWidget});
}

/*this is a round button normel button that
can reuse in the all project */
class RoundButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final Color buttonColor;
  const RoundButton(
      {required this.label,
      required this.imagePath,
      required this.buttonColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width / 3,
        height: height / 15,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Image.asset(
                imagePath,
                width: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

/*So this widget is used for create a slider of image
to view with pageindicator  */

class SliderImageViewWidget extends StatefulWidget {
  final List<String> imagePathList;
  const SliderImageViewWidget({required this.imagePathList, Key? key})
      : super(key: key);

  @override
  State<SliderImageViewWidget> createState() => _SliderImageViewWidgetState();
}

class _SliderImageViewWidgetState extends State<SliderImageViewWidget> {
  late PageController _pageController;
  double _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imagePath = widget.imagePathList;

    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height / 2,
      width: width / 1,
      child: Stack(
        children: [
          ListView.builder(
            controller: _pageController,
            itemCount: imagePath.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: height / 2,
                width: width / 1,
                child: imagePath[index].startsWith("asset/")
                    ? Image.asset(
                        imagePath[index],
                        fit: BoxFit.fill,
                      )
                    : Image.file(
                        File(imagePath[index]),
                        fit: BoxFit.fill,
                      ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 160,
            ),
            child: SizedBox(
              child: DotsIndicator(
                axis: Axis.vertical,
                dotsCount: imagePath.length,
                position: _currentIndex.round(),
                decorator: DotsDecorator(
                  color: Colors.grey,
                  activeColor: Colors.blue,
                  size: const Size.square(12.0),
                  activeSize: const Size(18.0, 19.0),
                  spacing: const EdgeInsets.all(5.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*this Widget is for back-Button common in every page
 */

class BackButtonWidget extends StatelessWidget {
  final double sizeOfImage;
  final bool isCHecked;
  const BackButtonWidget(
      {required this.sizeOfImage, required this.isCHecked, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isCHecked == true) {
          ScreenSelection.selectedIndexNotifier.value = 0;
          Navigator.pop(context);
        } else {
          ScreenSelection.selectedIndexNotifier.value = 0;
        }
      },
      child: Image.asset(
        "asset/imges/back-button.png",
        width: sizeOfImage,
      ),
    );
  }
}

/*in this widget is try to acheive the add favorite list according to the value */

class HeartButtonWidget extends StatefulWidget {
  final double sizeOfImage;
  final ModelPlace place;
  final Function(ModelPlace)? onFavoriteTapped;
  bool isFavorite;

  HeartButtonWidget({
    required this.sizeOfImage,
    required this.place,
    required this.isFavorite,
    this.onFavoriteTapped,
    Key? key,
  }) : super(key: key);

  @override
  _HeartButtonWidgetState createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  late ModelPlace _currentPlace;

  @override
  void initState() {
    super.initState();
    _currentPlace = widget.place;
  }

  // void _toggleFavoriteStatus() async {
  //   if (_isFavorite) {
  //     await FavoritesDB.instance.removeFavorite(_currentPlace);
  //     FavoritesDB.instance.updateFavoriteList();
  //   } else {
  //     await FavoritesDB.instance.addFavorite(_currentPlace);
  //     FavoritesDB.instance.updateFavoriteList();
  //   }
  //   widget.onFavoriteTapped?.call(_currentPlace);
  // }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = widget.isFavorite;
    return GestureDetector(
      onTap: () async {
        if (isFavorite) {
          await FavoritesDB.instance.removeFavorite(_currentPlace);
        } else {
          await FavoritesDB.instance.addFavorite(_currentPlace);
        }
        widget.onFavoriteTapped?.call(_currentPlace);
        FavoritesDB.instance.updateFavoriteList();
      },
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          isFavorite ? Colors.red : Colors.grey,
          BlendMode.srcIn,
        ),
        child: Image.asset(
          "asset/imges/heart-in-a-circle.png",
          width: widget.sizeOfImage,
        ),
      ),
    );
  }
}

/*This widget for build Listview for popular categories */

class PopularListViewWidget extends StatelessWidget {
  final ValueNotifier<List<ModelPlace>> placeListNotifierPopular;
  final void Function(ModelPlace)? onPlaceSelected;
  const PopularListViewWidget({
    required this.placeListNotifierPopular,
    this.onPlaceSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
      valueListenable: placeListNotifierPopular,
      builder: (context, placeList, _) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: placeList.length,
          itemBuilder: (context, index) {
            ModelPlace place = placeList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  onPlaceSelected!(place);
                  Navigator.pop(context);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: width / 4,
                  height: height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: width / 1,
                        height: height / 1,
                        child: getImageWidget(place.images![0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 30,
                        ),
                        child: Text(
                          place.placeName!,
                          style: GoogleFonts.abel(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
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
