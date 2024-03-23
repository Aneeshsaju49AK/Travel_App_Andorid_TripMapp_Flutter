import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tripmakerflutterapp/controller/addTrip_model/addTrip_model_controller.dart';
import 'package:tripmakerflutterapp/controller/blog_model/blog_model_controller.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/firebase_options.dart';
import 'package:tripmakerflutterapp/model/addTrip_model/addTrip_model.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';
import 'package:tripmakerflutterapp/provider/activity_page_provider.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/favorite_page_provider.dart';
import 'package:tripmakerflutterapp/provider/main_dart_provider.dart';
import 'package:tripmakerflutterapp/provider/maplocation_provider.dart';
import 'package:tripmakerflutterapp/provider/profile_page_provider.dart';
import 'package:tripmakerflutterapp/provider/searchwidget_provider.dart';
import 'package:tripmakerflutterapp/provider/tab_view_provider.dart';
import 'package:tripmakerflutterapp/provider/texiFieldWidget_provider.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/loginpage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter(ProfileModelsAdapter());
  Hive
    ..init(dir.path)
    ..registerAdapter(PlaceCategoryAdapter());

  // if (!Hive.isAdapterRegistered(PlaceCategoryAdapter().typeId)) {
  //   Hive.registerAdapter(PlaceCategoryAdapter());
  // }

  // if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)) {
  //   Hive.registerAdapter(ProfileModelAdapter());
  // }

  if (!Hive.isAdapterRegistered(BlogModelAdapter().typeId)) {
    Hive.registerAdapter(BlogModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TripModelAdapter().typeId)) {
    Hive.registerAdapter(TripModelAdapter());
  }

  if (!Hive.isAdapterRegistered(DistrictAdapter().typeId)) {
    Hive.registerAdapter(DistrictAdapter());
  }

  if (!Hive.isAdapterRegistered(ModelPlaceAdapter().typeId)) {
    Hive.registerAdapter(ModelPlaceAdapter());
  }
  await PlacesDB.instance.reFreshUI();
  await ProfileDB.instance.reFreshUIProfile();
  await AddtripDB.instance.refreshListUI();
  await BlogDB.instance.reFreshUIBlogs();
  await FavoritesDB.instance.updateFavoriteList();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderMainPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfilePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActivityPageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteButton(),
        ),
        ChangeNotifierProvider(
          create: (context) => TextFieldProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MapLocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabViewProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DarkModeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context, darkmodeProvider, child) {
        return MaterialApp(
          title: "TripMapp",
          theme: ThemeData(
            brightness:
                darkmodeProvider.value ? Brightness.dark : Brightness.light,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          routes: {
            "LoginPage": (
              context,
            ) =>
                const LoginPage(),
          },
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // @override

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<ProviderMainPage>(context, listen: false);
    authProvider.initializeMainPage(context);

    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: width / 1,
          height: height / 1,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 300),
                child: SizedBox(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('asset/imges/pexels-photo-4220967.jpeg'),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: Text(
                          'Trip',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          'mapp',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            color: Colors.blue[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    child: Text(
                      'Know your city',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
