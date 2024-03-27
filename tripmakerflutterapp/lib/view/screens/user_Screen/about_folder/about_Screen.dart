import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/populatList_folder/commonwidget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                      width: 30,
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: width / 1,
                  height: height / 1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Application name : Trip Mapp",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "version :01.01.01",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Deveplore name : Aneesh",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "for feedbacks : aneeshsaju73@gmail.com",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "// User manual",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "'Hi there, Very happy to introduce our new app called Trip Mapp, \n* in this app your view the places which already there \n* you can't add or edit the places \n* you add the places as your favirotes or remove \n *you can update your profile \n* you can create you on trip plans for future \n* you can make you own blogs about any places you visit '",
                        style: GoogleFonts.abel(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
