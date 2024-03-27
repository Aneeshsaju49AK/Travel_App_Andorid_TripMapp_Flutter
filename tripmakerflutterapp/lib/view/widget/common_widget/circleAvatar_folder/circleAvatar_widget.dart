/*this circle avatar is created to reuse the widget with in home 
drawer */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/provider/darkmode_page_provider/darkMode_provider.dart';

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
