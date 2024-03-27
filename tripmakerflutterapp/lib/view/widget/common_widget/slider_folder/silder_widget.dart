/* the sildeViewWidget is created to use
in home page and tripplan page */

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmakerflutterapp/controller/firebase_controller/firebase_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/category_folder/category_place.dart';

class SilderViewWidget extends StatelessWidget {
  SilderViewWidget({super.key});
  final List<CategoryDataOption> categories = [
    CategoryDataOption(
      title: "Hill Stations",
      imagePath: "asset/imges/categies_img/pexels-mikhail-nilov-8321369.jpg",
      placeListNotifierSilderWidget:
          ControllerFirebase.instance.hillStationCatrgoryListNotifier,
    ),
    CategoryDataOption(
      title: "Monuments",
      imagePath: "asset/imges/categies_img/pexels-setu-chhaya-9455189.jpg",
      placeListNotifierSilderWidget:
          ControllerFirebase.instance.momumentsCategoryListNotifier,
    ),
    CategoryDataOption(
      title: "Waterfalls",
      imagePath: "asset/imges/categies_img/pexels-aleksey-kuprikov-3715436.jpg",
      placeListNotifierSilderWidget:
          ControllerFirebase.instance.waterfallsCategoryListNotifier,
    ),
    CategoryDataOption(
      title: "Forests",
      imagePath: "asset/imges/categies_img/pexels-veeterzy-38136.jpg",
      placeListNotifierSilderWidget:
          ControllerFirebase.instance.forestsCategoryNotifier,
    ),
    CategoryDataOption(
      title: "Beaches",
      imagePath:
          "asset/imges/categies_img/pexels-asad-photo-maldives-1450372.jpg",
      placeListNotifierSilderWidget:
          ControllerFirebase.instance.beachCategoryNotifier,
    ),
    CategoryDataOption(
      title: "Deserts",
      imagePath: "asset/imges/categies_img/pexels-denys-gromov-13252308.jpg",
      placeListNotifierSilderWidget:
          ControllerFirebase.instance.lakeCategoryNotifier,
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

  CategoryDataOption({
    required this.title,
    required this.imagePath,
    required this.placeListNotifierSilderWidget,
  });
}
