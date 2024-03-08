import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width / 1,
          height: height / 1,
          color: Colors.amber,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 25,
                ),
                child: Row(
                  children: [
                    const BackButtonWidget(
                      sizeOfImage: 30,
                      isCHecked: true,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "About",
                      style: GoogleFonts.abel(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    )
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
