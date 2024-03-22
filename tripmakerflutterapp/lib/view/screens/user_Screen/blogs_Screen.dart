import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/blog_model/blog_model_controller.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/profile_page_provider.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class BlogsScreenWidget extends StatelessWidget {
  const BlogsScreenWidget({super.key});

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
                            "No blogs is created",
                            style: GoogleFonts.abel(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: valueList.length,
                        itemBuilder: (context, index) {
                          BlogModel place = valueList[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              width: width / 1,
                              height: height / 3.5,
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: width / 1,
                                    height: height / 3.5,
                                    child: auth.getImageWidget(
                                      place.images![0],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      top: 30,
                                    ),
                                    child: Text(place.name!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      top: 90,
                                    ),
                                    child: Text(place.content!),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 120,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        BlogDB.instance
                                            .deletePlaces(place.id)
                                            .then((value) async {
                                          await BlogDB.instance
                                              .reFreshUIBlogs();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.red,
                                      ),
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
                      color: Colors.yellow[50],
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

class PopupScreen extends StatelessWidget {
  PopupScreen({super.key});

  int countImage = 0;

  final List<String> _images = [];

  TextEditingController nameController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // String? validateError(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please enter a valid value";
  //   }
  //   return null;
  // }

  void handleSavebuttonBlogPage(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final blog = BlogModel(
        id: DateTime.now().microsecond,
        name: nameController.text,
        content: contentController.text,
        images: _images,
      );
      await BlogDB.instance.insertBlog(blog);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('User added successfully'),
          backgroundColor: Colors.green[200],
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProfileProvider = Provider.of<ProfilePageProvider>(
      context,
    );
    final auth = Provider.of<CommonProvider>(context);
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: width / 1,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  child: Text(
                    "Make your blogs",
                    style: GoogleFonts.abel(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    countImage,
                    (index) {
                      return Visibility(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: width / 1.4,
                                height: height / 4,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: index <
                                            authProfileProvider.images.length
                                        ? FileImage(
                                            File(authProfileProvider
                                                .images[index]),
                                          )
                                        : FileImage(
                                            File(""),
                                          ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    authProfileProvider.decreaseCount(index);
                                    // setState(() {
                                    //   countImage--;
                                    // });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    authProfileProvider.buttomSheet(
                                        context, true);
                                    // buttomSheet(context);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    authProfileProvider.increament();
                    // setState(() {
                    //   countImage++;
                    // });
                  },
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text("Add Image"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Name your blog"),
                SizedBox(
                  width: width / 1.2,
                  height: height / 12,
                  child: TextFormField(
                    validator: auth.validateValue,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width / 1.2,
                  height: height / 4,
                  child: TextFormField(
                    validator: auth.validateValue,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 20,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          handleSavebuttonBlogPage(context);
                        },
                        child: const RoundButton(
                          label: "Save",
                          imagePath: "asset/imges/navigation_img/eye.png",
                          buttonColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      const RoundButton(
                        label: "Clear",
                        imagePath: "asset/imges/navigation_img/eye.png",
                        buttonColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
