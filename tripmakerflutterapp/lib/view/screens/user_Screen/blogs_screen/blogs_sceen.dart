import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/addTrip_model/addTrip_model_controller.dart';
import 'package:tripmakerflutterapp/controller/blog_model/blog_model_controller.dart';
import 'package:tripmakerflutterapp/model/addTrip_model/addTrip_model.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/blogs_screen/blogView_screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/blogs_screen/blogs_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/headWwite_widget/headwrite_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/heartButton_folder/heartbutton_widget.dart';

class BlogsScreenWidget extends StatefulWidget {
  const BlogsScreenWidget({super.key});

  @override
  State<BlogsScreenWidget> createState() => _BlogsScreenWidgetState();
}

class _BlogsScreenWidgetState extends State<BlogsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<CommonProvider>(context);
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: width / 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 45,
                        left: 12,
                      ),
                      child: BackButtonWidget(
                        sizeOfImage: 40,
                        isCHecked: false,
                      ),
                    ),
                    HeadWritingWidget(
                      label: "Blogs & Comment",
                      divideHeight: 9,
                      divideWidth: 1.2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: width / 1,
                  height: height / 1.3,
                  child: ValueListenableBuilder(
                    valueListenable: BlogDB.instance.blogsallNotifier,
                    builder: (context, valueList, _) {
                      if (valueList.isEmpty) {
                        return Center(
                          child: Text(
                            "No trip is planned",
                            style: GoogleFonts.abel(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: valueList.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          BlogModel place = valueList[index];

                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: width / 1,
                              height: height / 3.5,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Consumer<CommonProvider>(
                                    builder: (context, value, child) {
                                      return SizedBox(
                                        width: width / 1,
                                        height: height / 3.5,
                                        child: value.getImageWidget(
                                          place.images![0],
                                        ),
                                      );
                                    },
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: height / 7,
                                    left: 20,
                                    child: SizedBox(
                                      width: width / 1.5,
                                      child: FittedBox(
                                          child: Text(
                                        place.name!,
                                        style: GoogleFonts.abel(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                    ),
                                  ),
                                  Positioned(
                                    top: height / 5.5,
                                    child: SizedBox(
                                      width: width / 2,
                                      height: height / 23,
                                      child: FittedBox(
                                          child: Text(
                                        place.name!,
                                        style: GoogleFonts.abel(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                    ),
                                  ),
                                  // Text(place.startDate!.toString()),
                                  // Positioned(
                                  //   top: height / 4.5,
                                  //   child: SizedBox(
                                  //     width: width / 2,
                                  //     height: height / 35,
                                  //     child: FittedBox(
                                  //         child: Text(
                                  //       place.startDate!
                                  //           .toString()
                                  //           .substring(0, 10),
                                  //       style: GoogleFonts.abel(
                                  //         color: Colors.white,
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.w700,
                                  //       ),
                                  //     )),
                                  //   ),
                                  // ),
                                  // Positioned(
                                  //   top: height / 4,
                                  //   child: SizedBox(
                                  //     width: width / 2,
                                  //     height: height / 35,
                                  //     child: FittedBox(
                                  //         child: Text(
                                  //       place.endDate!
                                  //           .toString()
                                  //           .substring(0, 10),
                                  //       style: GoogleFonts.abel(
                                  //         color: Colors.white,
                                  //         fontSize: 15,
                                  //         fontWeight: FontWeight.w700,
                                  //       ),
                                  //     )),
                                  //   ),
                                  // ),
                                  Positioned(
                                    left: width / 1.7,
                                    top: height / 30,
                                    child: Row(
                                      children: [
                                        // HeartButtonWidget(
                                        //   sizeOfImage: 40,
                                        //   place: place.selectedPlace!,
                                        //   isFavorite: true,
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Logout"),
                                                  content: const Text(
                                                      "Are you sure you want to remove Trip?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("No"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        BlogDB.instance
                                                            .deletePlaces(
                                                                place.id)
                                                            .then(
                                                          (value) {
                                                            AddtripDB.instance
                                                                .refreshListUI();
                                                          },
                                                        );
                                                      },
                                                      child: const Text("Yes"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   width: width / 1,
                //   height: height / 1.3,
                //   child: ValueListenableBuilder(
                //     valueListenable: BlogDB.instance.blogsallNotifier,
                //     builder: (context, valueList, _) {
                //       if (valueList.isEmpty) {
                //         return Center(
                //           child: Text(
                //             "No blogs is created",
                //             style: GoogleFonts.abel(
                //               fontSize: 20,
                //               fontWeight: FontWeight.w500,
                //               color: Provider.of<DarkModeProvider>(context)
                //                       .value
                //                   ? const Color.fromARGB(255, 33, 39, 43)
                //                   : const Color.fromARGB(255, 230, 234, 212),
                //             ),
                //           ),
                //         );
                //       }
                //       return ListView.builder(
                //         itemCount: valueList.length,
                //         itemBuilder: (
                //           context,
                //           index,
                //         ) {
                //           BlogModel place = valueList[index];
                //           return Padding(
                //             padding: const EdgeInsets.all(20.0),
                //             child: InkWell(
                //               onTap: () {
                //                 Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                     builder: (context) => BlogViewPage(
                //                       place: place,
                //                     ),
                //                   ),
                //                 );
                //               },
                //               child: Container(
                //                 clipBehavior: Clip.antiAlias,
                //                 width: width / 1,
                //                 height: height / 3.5,
                //                 decoration: const BoxDecoration(
                //                   borderRadius: BorderRadius.all(
                //                     Radius.circular(20),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return PopupScreen();
          //   },
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  body: SafeArea(
                    child: Container(
                      color: Provider.of<DarkModeProvider>(context).value
                          ? const Color.fromARGB(255, 33, 39, 43)
                          : const Color.fromARGB(255, 230, 234, 212),
                      child: PopupScreen(),
                    ),
                  ),
                );
              },
            ),
          ).then(
            (value) async {
              await BlogDB.instance.reFreshUIBlogs();
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  // Widget getImageWidget(String imagePath) {
  //   if (imagePath.startsWith("assets/")) {
  //     return Image.asset(
  //       imagePath,
  //       fit: BoxFit.cover,
  //     );
  //   } else {
  //     return Image.file(
  //       File(imagePath),
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }
}
