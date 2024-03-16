import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/controller/addTrip_model/addTrip_model_controller.dart';
import 'package:tripmakerflutterapp/controller/blog_model/blog_model_controller.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/addTrip_model/addTrip_model.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/loginpage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(BlogModelAdapter().typeId)) {
    Hive.registerAdapter(BlogModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TripModelAdapter().typeId)) {
    Hive.registerAdapter(TripModelAdapter());
  }
  if (!Hive.isAdapterRegistered(DistrictAdapter().typeId)) {
    Hive.registerAdapter(DistrictAdapter());
  }
  if (!Hive.isAdapterRegistered(PlaceCategoryAdapter().typeId)) {
    Hive.registerAdapter(PlaceCategoryAdapter());
  }

  if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)) {
    Hive.registerAdapter(ProfileModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ModelPlaceAdapter().typeId)) {
    Hive.registerAdapter(ModelPlaceAdapter());
  }

  await getUserValue();
  await PlacesDB.instance.reFreshUI();
  await AddtripDB.instance.refreshListUI();
  await BlogDB.instance.reFreshUIBlogs();
  await FavoritesDB.instance.updateFavoriteList();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DarkModeProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
            "LoginPage": (context) => LoginPage(),
          },
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

        if (isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenSelection(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
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
