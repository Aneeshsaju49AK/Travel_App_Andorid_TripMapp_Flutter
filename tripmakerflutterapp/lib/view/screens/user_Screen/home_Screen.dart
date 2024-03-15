import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/activity_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/addtrip_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/blogs_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/drawer_screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/favorite_List.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/profile_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/Navigation.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class ScreenSelection extends StatelessWidget {
  ScreenSelection({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    const HomeScreen(),
    const AddTripScreen(),
    const ActivityScreenWidget(),
    const BlogsScreenWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (
              context,
              updatedIndex,
              _,
            ) {
              return _pages[updatedIndex];
            },
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  String? _currentLocationName;

// Inside a function or during app initialization

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () async {
        final prefs = await SharedPreferences.getInstance();
        final isProfileSet = prefs.getBool("isProfileSet") ?? false;

        var status = await Permission.location.request();
        if (status == PermissionStatus.granted) {
          // Permission granted, try getting the location again
          _getCurrentLocation();
        } else {
          // Permission denied
          print('Location permission denied');
        }

        if (isProfileSet != true) {
          prefs.setBool("isProfileSet", true);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  body: SafeArea(
                    child: ProfileSetupWidget(),
                  ),
                );
              },
            ),
          );
        } else {
          return;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                SizedBox(
                  width: width / 1,
                  height: height / 7.5,
                  child: Row(
                    children: [
                      Hero(
                        tag: "drawer",
                        child: SizedBox(
                          width: width / 3.5,
                          height: height / 11,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DrawerScreen(),
                                ),
                              );
                            },
                            child: ValueListenableBuilder<List<ProfileModel>>(
                              valueListenable: userListNotifier,
                              builder: (context, userList, _) {
                                if (userList.isNotEmpty) {
                                  return CircleAvatarWidget(
                                    radius: 34,
                                    islocationwidget: true,
                                    imagePath: userList[0].profilePicturePath,
                                  );
                                } else {
                                  return const CircleAvatarWidget(
                                    radius: 34,
                                    imagePath: null,
                                    islocationwidget: true,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width / 3.3,
                        height: height / 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 28,
                              ),
                              child: Text(
                                "Welcome",
                                style: GoogleFonts.rubik(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            ValueListenableBuilder<List<ProfileModel>>(
                              valueListenable: userListNotifier,
                              builder: (context, userList, _) {
                                if (userList.isNotEmpty) {
                                  return Text(
                                    userList[0].userName!,
                                    style: GoogleFonts.rubik(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "Guest",
                                    style: GoogleFonts.rubik(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width / 2.5,
                        height: height / 1,
                        child: SizedBox(
                          width: width / 1,
                          height: height / 1.5,
                          child: SizedBox(
                            width: width / 2,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FavoritePage(),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height / 1,
                                  width: width / 3.9,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 35),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          // CircleAvatarWidget(
                                          //   radius: 23,
                                          //   location: _currentPosition,
                                          //   locationName: _currentLocationName,
                                          //   islocationwidget: false,
                                          // ),
                                          Icon(Icons.location_pin),
                                          MapLocation(
                                            islocationWidget: true,
                                            location: _currentPosition,
                                            locationName: _currentLocationName,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 1,
                  height: height / 9.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 19,
                        ),
                        child: Text(
                          "Life Is Journey",
                          style: GoogleFonts.abel(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 19,
                        ),
                        child: Text(
                          "Make the best of it.",
                          style: GoogleFonts.abel(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SearchWidget(
                  isNavigation: true,
                ),
                const TabViewWidget(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width / 1.1,
                  height: height / 3,
                  child: SilderViewWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: width / 1,
        height: height / 16,
        child: const NavigationBarWidget(),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        _currentPosition = position;
        _currentLocationName =
            "${placemarks.first.name}, ${placemarks.first.locality}";
      });
    } catch (e) {
      print(e);
    }
  }
}
