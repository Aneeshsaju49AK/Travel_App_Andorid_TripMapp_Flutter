import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/blog_model/blog_model_controller.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/blogView_screen.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class BlogsScreenWidget extends StatefulWidget {
  const BlogsScreenWidget({super.key});

  @override
  State<BlogsScreenWidget> createState() => _BlogsScreenWidgetState();
}

class _BlogsScreenWidgetState extends State<BlogsScreenWidget> {
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
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color:
                                  Provider.of<DarkModeProvider>(context).value
                                      ? Color.fromARGB(255, 195, 206, 212)
                                      : Color.fromARGB(255, 230, 234, 212),
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
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogViewPage(
                                      place: place,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                width: width / 1,
                                height: height / 3.5,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: width / 1,
                                      height: height / 3.5,
                                      child: getImageWidget(
                                        place.images![0],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      top: 170,
                                      child: Text(
                                        place.name!,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Provider.of<DarkModeProvider>(
                                                      context)
                                                  .value
                                              ? const Color.fromARGB(
                                                  255, 33, 39, 43)
                                              : Color.fromARGB(
                                                  255, 230, 234, 212),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: width / 1.4,
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Remove"),
                                                content: Text(
                                                    "Are you sure you want to remove your blog?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("No"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      BlogDB.instance
                                                          .deletePlaces(
                                                              place.id);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Yes"),
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
                          : Color.fromARGB(255, 230, 234, 212),
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

  Widget getImageWidget(String imagePath) {
    if (imagePath.startsWith("assets/")) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    }
  }
}

class PopupScreen extends StatefulWidget {
  const PopupScreen({super.key});

  @override
  State<PopupScreen> createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen> {
  int countImage = 0;
  final List<String> _images = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    contentController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  String? validateError(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid value";
    }
    return null;
  }

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
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width / 1,
          color: Provider.of<DarkModeProvider>(context).value
              ? const Color.fromARGB(255, 33, 39, 43)
              : Color.fromARGB(255, 230, 234, 212),
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
                      color: Provider.of<DarkModeProvider>(context).value
                          ? Color.fromARGB(255, 212, 223, 231)
                          : Color.fromARGB(255, 60, 61, 57),
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
                                    image: index < _images.length
                                        ? FileImage(
                                            File(_images[index]),
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
                                    setState(() {
                                      countImage--;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color:
                                        Provider.of<DarkModeProvider>(context)
                                                .value
                                            ? Color.fromARGB(255, 143, 170, 188)
                                            : Color.fromARGB(255, 60, 61, 57),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    buttomSheet(context);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color:
                                        Provider.of<DarkModeProvider>(context)
                                                .value
                                            ? Color.fromARGB(255, 150, 178, 196)
                                            : Color.fromARGB(255, 60, 61, 57),
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
                    setState(() {
                      countImage++;
                    });
                  },
                  icon: const Icon(
                    Icons.add_a_photo,
                  ),
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
                    controller: nameController,
                    validator: validateError,
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
                    controller: contentController,
                    validator: validateError,
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

  buttomSheet(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return showBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: width / 1,
          height: height / 5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select the image source",
                  style: GoogleFonts.abel(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      XFile? img = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );
                      if (img != null) {
                        setState(() {
                          _images.add(img.path);
                        });

                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera"),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      XFile? img = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      if (img != null) {
                        setState(() {
                          _images.add(img.path);
                        });

                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Galley"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
