/*this is a round button normel button that
can reuse in the all project */
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final Color buttonColor;
  const RoundButton(
      {required this.label,
      required this.imagePath,
      required this.buttonColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width / 3,
        height: height / 15,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Image.asset(
                imagePath,
                width: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
