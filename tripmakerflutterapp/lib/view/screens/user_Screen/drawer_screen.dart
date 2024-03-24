import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/about_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/profile_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/circleAvatar_folder/circleAvatar_widget.dart';

import '../../widget/common_widget/populatList_folder/commonwidget.dart';

class DrawerScreen extends StatefulWidget {
  DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileDB.instance.reFreshUIProfile();
  }

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
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 80,
                ),
                child: BackButtonWidget(sizeOfImage: 30, isCHecked: true),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 40,
                ),
                child: SizedBox(
                  width: width / 1,
                  height: height / 7,
                  child: ValueListenableBuilder<List<ProfileModels>>(
                    valueListenable: ProfileDB.userListNotifier,
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
                height: height / 2.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 40,
                      ),
                      child: SizedBox(
                        width: width / 2,
                        height: height / 10,
                        child: ValueListenableBuilder<List<ProfileModels>>(
                          valueListenable: ProfileDB.userListNotifier,
                          builder: (context, userList, _) {
                            if (userList.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      userList[0].name!,
                                      style: GoogleFonts.abel(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Provider.of<DarkModeProvider>(
                                                    context)
                                                .value
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    userList[0].email!,
                                    style: GoogleFonts.abel(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Provider.of<DarkModeProvider>(context)
                                                  .value
                                              ? Colors.blue
                                              : Colors.black,
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    "Guestname",
                                    style: GoogleFonts.abel(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Provider.of<DarkModeProvider>(context)
                                                  .value
                                              ? Colors.blue
                                              : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Guestmail",
                                    style: GoogleFonts.abel(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Provider.of<DarkModeProvider>(context)
                                                  .value
                                              ? Colors.blue
                                              : Colors.black,
                                    ),
                                  ),
                                ],
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
                                            return Scaffold(
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
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Logout"),
                                            content: const Text(
                                                "Are you sure you want to logout?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("No"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  _logOutUser(context);
                                                },
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      break;
                                  }
                                },
                                child: Text(
                                  links[index],
                                  style: GoogleFonts.abel(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Provider.of<DarkModeProvider>(context)
                                                .value
                                            ? Colors.blue
                                            : Colors.black,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: GoogleFonts.abel(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Provider.of<DarkModeProvider>(context).value
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                    Switch(
                      value: Provider.of<DarkModeProvider>(context).value,

                      // value: isDarkModeEnabled.value,
                      onChanged: (value) {
                        Provider.of<DarkModeProvider>(context, listen: false)
                            .setValue(value);
                        // setState(() {
                        //   isDarkModeEnabled.value = value;
                        // });
                      },
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
