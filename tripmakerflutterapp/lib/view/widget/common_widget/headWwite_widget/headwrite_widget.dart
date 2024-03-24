/*this widget is mainly used to write the head of 

  signup and login page head */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadWritingWidget extends StatelessWidget {
  final String label;
  final double? divideWidth;
  final double? divideHeight;
  const HeadWritingWidget({
    Key? key,
    required this.label,
    this.divideHeight,
    this.divideWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width / divideWidth!,
      height: height / divideHeight!,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          top: 50,
        ),
        child: Text(
          label,
          style: GoogleFonts.abel(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
