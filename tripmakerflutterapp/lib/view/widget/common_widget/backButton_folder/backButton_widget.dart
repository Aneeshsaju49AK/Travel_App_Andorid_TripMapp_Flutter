/*this Widget is for back-Button common in every page
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';

class BackButtonWidget extends StatefulWidget {
  final double sizeOfImage;
  final bool? isCHecked;
  const BackButtonWidget(
      {required this.sizeOfImage, required this.isCHecked, super.key});

  @override
  State<BackButtonWidget> createState() => _BackButtonWidgetState();
}

class _BackButtonWidgetState extends State<BackButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isCHecked == true) {
          ScreenSelection.selectedIndexNotifier.value = 0;
          Navigator.pop(context);
        } else if (widget.isCHecked == false) {
          ScreenSelection.selectedIndexNotifier.value = 0;
        } else {
          Navigator.pop(context);
        }
      },
      child: Image.asset(
        "asset/imges/back-button.png",
        width: widget.sizeOfImage,
        color: Provider.of<DarkModeProvider>(context).value
            ? Colors.blue
            : Colors.black,
      ),
    );
  }
}
