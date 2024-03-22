import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmakerflutterapp/view/screens/admin_Screen/add_place.dart';

class ScreenHomeAdmin extends StatelessWidget {
  ScreenHomeAdmin({super.key});

  final List<String> options = [
    "Add Place",
  ];

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "List of menu",
                style: GoogleFonts.abel(
                  fontSize: 45,
                ),
              ),
              SizedBox(
                width: width / 1,
                height: height / 1.1,
                child: SizedBox(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Scaffold(
                                  body: SafeArea(
                                    child: AddPlaceAdmin(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.amber,
                          width: width / 2,
                          height: height / 3,
                          child: Center(
                            child: Text(
                              options[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
