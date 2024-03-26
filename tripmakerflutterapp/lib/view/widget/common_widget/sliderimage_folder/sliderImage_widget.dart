/*So this widget is used for create a slider of image
to view with pageindicator  */

import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/provider/tab_view_provider.dart';

class SliderImageViewWidget extends StatefulWidget {
  final List<String> imagePathList;
  const SliderImageViewWidget({required this.imagePathList, Key? key})
      : super(key: key);

  @override
  State<SliderImageViewWidget> createState() => _SliderImageViewWidgetState();
}

class _SliderImageViewWidgetState extends State<SliderImageViewWidget> {
  // late PageController _pageController;
  // double _currentIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController(
  //     initialPage: 0,
  //   );
  //   _pageController.addListener(() {
  //     setState(() {
  //       _currentIndex = _pageController.page!;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

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
                    child: imagePath[index].startsWith("https://")
                        ? Image.network(
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
