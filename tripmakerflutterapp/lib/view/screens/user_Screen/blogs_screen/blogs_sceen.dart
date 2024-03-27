import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/blog_model/blog_model_controller.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/provider/common_page_provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/darkmode_page_provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/blogs_screen/blogView_screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/blogs_screen/blogs_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/headWwite_widget/headwrite_widget.dart';

class BlogsScreenWidget extends StatefulWidget {
  const BlogsScreenWidget({super.key});

  @override
  State<BlogsScreenWidget> createState() => _BlogsScreenWidgetState();
}

class _BlogsScreenWidgetState extends State<BlogsScreenWidget> {
  late BlogModel blog;
  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: width / 1,
            child: Column(
              children: [
                const Row(
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
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                SizedBox(
                  width: width / 1,
                  height: height / 1.3,
                  child: ValueListenableBuilder(
                    valueListenable: BlogDB.instance.blogsallNotifier,
                    builder: (context, valueList, _) {
                      if (valueList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No blogs is planned",
                                style: GoogleFonts.abel(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Image.asset(
                                "asset/imges/emoji.png",
                                scale: 3,
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: valueList.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          BlogModel blog = valueList[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BlogViewPage(place: blog),
                                  ));
                            },
                            child: Padding(
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
                                    SizedBox(
                                      width: width / 1,
                                      height: height / 3.5,
                                      child: Provider.of<CommonProvider>(
                                              context,
                                              listen: false)
                                          .getImageWidget(
                                        blog.images![0],
                                      ),
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
                                      left: width / 1.5,
                                      top: height / 34,
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
                                                builder:
                                                    (BuildContext context) {
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
                                                                  blog.id)
                                                              .then(
                                                            (value) {
                                                              BlogDB.instance
                                                                  .reFreshUIBlogs();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        },
                                                        child:
                                                            const Text("Yes"),
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
                                    Positioned(
                                      top: 100,
                                      left: 20,
                                      child: SizedBox(
                                        width: width / 1.5,
                                        child: FittedBox(
                                            child: SizedBox(
                                          width: width / 2,
                                          child: Text(
                                            blog.name!,
                                            style: GoogleFonts.abel(
                                              color: const Color.fromARGB(
                                                  255, 221, 232, 230),
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
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
                      child: const PopupScreen(),
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
