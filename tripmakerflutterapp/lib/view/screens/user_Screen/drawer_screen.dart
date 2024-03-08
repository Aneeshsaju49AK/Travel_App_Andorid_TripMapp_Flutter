import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/about_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';

import 'package:tripmakerflutterapp/view/screens/user_Screen/profile_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final links = [
      "Home",
      "Profile",
      "About",
      "Logout",
    ];
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: width / 2,
          height: height / 1,
          color: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  right: 120,
                  top: 30,
                ),
                child: BackButtonWidget(
                  sizeOfImage: 30,
                  isCHecked: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                ),
                child: SizedBox(
                  width: width / 1,
                  height: height / 7,
                  child: ValueListenableBuilder<List<ProfileModel>>(
                    valueListenable: userListNotifier,
                    builder: (context, userList, _) {
                      if (userList.isNotEmpty) {
                        return CircleAvatarWidget(
                          radius: 50,
                          imagePath: userList[0].profilePicturePath,
                          islocationwidget: true,
                        );
                      } else {
                        return const CircleAvatarWidget(
                          radius: 50,
                          islocationwidget: true,
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: width / 2,
                height: height / 2.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                      ),
                      child: SizedBox(
                        width: width / 2,
                        height: height / 30,
                        child: ValueListenableBuilder<List<ProfileModel>>(
                          valueListenable: userListNotifier,
                          builder: (context, userList, _) {
                            if (userList.isNotEmpty) {
                              return Text(
                                userList[0].name!,
                                style: GoogleFonts.abel(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            } else {
                              return Text(
                                "Guest",
                                style: GoogleFonts.abel(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                      ),
                      child: SizedBox(
                        width: width / 2,
                        height: height / 31,
                        child: ValueListenableBuilder<List<ProfileModel>>(
                          valueListenable: userListNotifier,
                          builder: (context, userList, _) {
                            if (userList.isNotEmpty) {
                              return Text(
                                userList[0].email!,
                                style: GoogleFonts.abel(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            } else {
                              return Text(
                                "Guestmail",
                                style: GoogleFonts.abel(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 2,
                      height: height / 2.8,
                      child: ListView.builder(
                        itemCount: links.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: width / 2,
                            height: height / 14,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 40,
                                top: 20,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      ScreenSelection
                                          .selectedIndexNotifier.value = 0;
                                      Navigator.pop(context);
                                      break;
                                    case 1:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const Scaffold(
                                              body: SafeArea(
                                                child: ProfileSetupWidget(),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                      break;
                                    case 2:
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AboutScreen(),
                                        ),
                                      );
                                      break;
                                    case 3:
                                      _logOutUser(context);
                                      break;
                                  }
                                },
                                child: Text(
                                  links[index],
                                  style: GoogleFonts.abel(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _logOutUser(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", false);

  Navigator.of(context).pushNamedAndRemoveUntil("LoginPage", (route) => false);
}
