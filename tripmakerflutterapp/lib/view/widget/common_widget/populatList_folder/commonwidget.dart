import 'dart:io';
import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/maplocation_provider.dart';
import 'package:tripmakerflutterapp/provider/searchwidget_provider.dart';
import 'package:tripmakerflutterapp/provider/tab_view_provider.dart';
import 'package:tripmakerflutterapp/provider/texiFieldWidget_provider.dart';

import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
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

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function()? onChange;

  final TextEditingController? controller;
  final TextInputType keyboardType;

  const TextFieldWidget({
    Key? key,
    required this.label,
    this.validator,
    this.controller,
    this.onChange,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  // late TextEditingController _controller;
  final bool showError = false;

  // @override
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<TextFieldProvider>(context);
    auth.initController(controller);
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width / 1,
      height: showError ? height / 6 : height / 4.5,
      child: Column(
        children: [
          SizedBox(
            width: width / 1,
            height: showError ? height / 20 : height / 12,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                label,
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
              height: showError ? height / 23 : height / 10,
              child: TextFormField(
                keyboardType: keyboardType,
                controller: auth.controller,
                decoration: InputDecoration(
                  hintText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: validator,
                onTap: onChange,
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

class MapLocation extends StatelessWidget {
  final bool? islocationWidget;
  final Position? location;
  final String? locationName;
  const MapLocation({
    this.islocationWidget,
    this.location,
    this.locationName,
    Key? key,
  }) : super(key: key);

//  final bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MapLocationProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            value.changeValue();
            // setState(() {
            //   showFullText = !showFullText;
            // });
          },
          child: Container(
            child: islocationWidget == true && location != null
                ? Text(
                    value.showFullText
                        ? "$locationName"
                        : "${locationName!.substring(0, 10)}...", // Display only the first 10 characters
                  )
                : const Text("Location not available"),
          ),
        );
      },
      // child: Container(
      //   child: widget.islocationWidget == true && widget.location != null
      //       ? Text(
      //           showFullText
      //               ? "${widget.locationName}"
      //               : "${widget.locationName!.substring(0, 10)}...", // Display only the first 10 characters
      //         )
      //       : const Text("Location not available"),
      // ),
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
                    color: Provider.of<DarkModeProvider>(context).value
                        ? Colors.blue
                        : Colors.black,
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
class SearchWidget extends StatelessWidget {
  final bool isNavigation;
  final void Function(String)? onSearch;

  const SearchWidget({
    required this.isNavigation,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  // TextEditingController searchController = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<SearchProvider>(context);
    auth.listenText();
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 0,
        ),
        child: TextField(
          controller: auth.searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: 'Search for the Destinations',
            prefixIcon: IconButton(
              onPressed: () {
                if (isNavigation == true) {
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
    // final auth = Provider.of<TabViewProvider>(context, listen: false);
    // auth.initTabController(this);
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
              labelColor: Provider.of<DarkModeProvider>(context).value
                  ? Colors.white
                  : Colors.black,
              labelStyle: TextStyle(
                color: Provider.of<DarkModeProvider>(context).value
                    ? Colors.white
                    : Colors.black,
              ),
              controller: _tabController,
              tabs: const [
                FittedBox(
                  child: Tab(
                    text: 'Most Popular',
                  ),
                ),
                FittedBox(
                  child: Tab(
                    text: 'Recommended',
                  ),
                ),
                FittedBox(
                  child: Tab(
                    text: 'Trending',
                  ),
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
                        PlacesDB.instance.momumentsCategoryListNotifier,
                  ),
                ),
                SizedBox(
                  child: TabBarListWidget(
                    placeListNotifierCommon:
                        PlacesDB.instance.beachCategoryNotifier,
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
                      gradient: const LinearGradient(
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
      child: Consumer<TabViewProvider>(
        builder: (context, value, _) {
          value.initPageController();
          return Stack(
            children: [
              ListView.builder(
                controller: value.controllerpage,
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
                    position: value.currentIdex.round(),
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
          );
        },
      ),
    );
  }
}

/*in this widget is try to acheive the add favorite list according to the value */

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
                  child: Consumer<CommonProvider>(
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: width / 1,
                            height: height / 1,
                            child: value.getImageWidget(place.images![0]),
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
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Widget getImageWidget(String imagePath) {
  //   if (imagePath.startsWith("assets/")) {
  //     return Image.asset(
  //       imagePath,
  //       fit: BoxFit.cover,
  //     );
  //   } else {
  //     return Image.file(
  //       File(imagePath),
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }
}
