import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/blog_model/blog_model_controller.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/profile_page_provider.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/roundButton_folder/roundButton_widget.dart';

class PopupScreen extends StatelessWidget {
  PopupScreen({super.key});

  // int countImage = 0;

  // final List<String> _images = [];

  TextEditingController nameController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    contentController.dispose();
  }

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
        images: Provider.of<ProfilePageProvider>(context, listen: false).images,
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
    final auth = Provider.of<CommonProvider>(context);
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width / 1,
          color: Provider.of<DarkModeProvider>(context).value
              ? const Color.fromARGB(255, 33, 39, 43)
              : const Color.fromARGB(255, 230, 234, 212),
          child: Form(
            key: _formKey,
            child: Consumer<ProfilePageProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    SizedBox(
                      child: Text(
                        "Make your blogs",
                        style: GoogleFonts.abel(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Provider.of<DarkModeProvider>(context).value
                              ? const Color.fromARGB(255, 212, 223, 231)
                              : const Color.fromARGB(255, 60, 61, 57),
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        value.countImage,
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
                                        image: index < value.images.length
                                            ? FileImage(
                                                File(value.images[index]),
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
                                        value.decreaseCount(index);
                                        // setState(() {
                                        //   countImage--;
                                        // });
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: Provider.of<DarkModeProvider>(
                                                    context)
                                                .value
                                            ? const Color.fromARGB(
                                                255, 143, 170, 188)
                                            : const Color.fromARGB(
                                                255, 60, 61, 57),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        value.buttomSheet(context, true);
                                        // buttomSheet(context);
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Provider.of<DarkModeProvider>(
                                                    context)
                                                .value
                                            ? const Color.fromARGB(
                                                255, 150, 178, 196)
                                            : const Color.fromARGB(
                                                255, 60, 61, 57),
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
                        value.increament();
                        // setState(() {
                        //   countImage++;
                        // });
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
                        controller: contentController,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
