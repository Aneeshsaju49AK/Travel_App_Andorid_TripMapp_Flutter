import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';

/* This class is for making the navigation possible through
the ValueListenerBuilder the no need to navigator.push */

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<NavigationItem> items = [
      NavigationItem(
          iconPath: "asset/imges/navigation_img/home-icon-silhouette.png"),
      NavigationItem(iconPath: "asset/imges/navigation_img/location.png"),
      NavigationItem(iconPath: "asset/imges/navigation_img/calendar.png"),
      NavigationItem(iconPath: "asset/imges/navigation_img/eye.png"),
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
      valueListenable: ScreenSelection.selectedIndexNotifier,
      builder: (context, updatedIndex, child) {
        return SizedBox(
          height: height / 17,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.5),
                child: SizedBox(
                  width: width / 4.5,
                  height: height / 3,
                  child: TextButton(
                    onPressed: () {
                      ScreenSelection.selectedIndexNotifier.value = index;
                      print("$index");
                    },
                    child: Image.asset(
                      items[index].iconPath,
                      color: Colors.blue,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class NavigationItem {
  final String iconPath;

  NavigationItem({required this.iconPath});
}
