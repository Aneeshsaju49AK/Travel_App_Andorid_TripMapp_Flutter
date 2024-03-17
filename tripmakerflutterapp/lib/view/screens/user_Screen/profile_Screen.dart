import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';

import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';

import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class ProfileSetupWidget extends StatefulWidget {
  const ProfileSetupWidget({Key? key}) : super(key: key);

  @override
  State<ProfileSetupWidget> createState() => _ProfileSetupWidgetState();
}

class _ProfileSetupWidgetState extends State<ProfileSetupWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileDB.userListNotifier;
  }

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final userNameController = TextEditingController();

  final phoneController = TextEditingController();

  String? _profilePicturePath;

  XFile? image;

  final _formKey = GlobalKey<FormState>();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter a valid name";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid Email";
    }
    return null;
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid Username";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid Phone Number";
    }
    return null;
  }

  void handleProfileUpdateButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final profile = ProfileModel(
        id: ProfileDB.userListNotifier.value[0].id,
        name: nameController.text,
        email: emailController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        profilePicturePath: _profilePicturePath,
      );
      await ProfileDB.instance.updateProfile(profile);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Updated Profile successfully'),
          backgroundColor: Colors.green[200],
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
  }

  void handleProfileSaveButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final profile = ProfileModel(
        id: DateTime.now().microsecond.toInt(),
        name: nameController.text,
        email: emailController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        profilePicturePath: _profilePicturePath,
      );
      await ProfileDB.instance.insertProfile(profile);

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height / .9,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: width / 1,
                    height: height / 7,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            top: 30,
                          ),
                          child: BackButtonWidget(
                            sizeOfImage: 30,
                            isCHecked: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 25,
                          ),
                          child: HeadWritingWidget(
                            label: "Profile",
                            divideWidth: 2,
                            divideHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width / 1,
                    height: height / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ValueListenableBuilder(
                        valueListenable: ProfileDB.userListNotifier,
                        builder: (context, value, _) {
                          if (value.isNotEmpty) {
                            return CircleAvatarWidget(
                              radius: 80,
                              islocationwidget: true,
                              imagePath: value[0].profilePicturePath,
                              onpressed: () {
                                buttomSheet(context);
                              },
                            );
                          } else {
                            return CircleAvatarWidget(
                              radius: 80,
                              islocationwidget: true,
                              imagePath: _profilePicturePath,
                              onpressed: () {
                                buttomSheet(context);
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: ProfileDB.userListNotifier,
                    builder: (context, value, _) {
                      ProfileModel pro = value[0];
                      nameController.text = pro.name! ?? '';
                      emailController.text = pro.email! ?? "";
                      userNameController.text = pro.userName! ?? "";
                      phoneController.text = pro.phone! ?? "";

                      return SizedBox(
                        width: width / 1,
                        height: height / 1.7,
                        child: Column(
                          children: [
                            TextFieldWidget(
                              label: "Name",
                              validator: validateName,
                              controller: nameController,
                            ),
                            TextFieldWidget(
                              label: "Email",
                              validator: validateEmail,
                              controller: emailController,
                            ),
                            TextFieldWidget(
                              label: "User Name",
                              validator: validateUserName,
                              controller: userNameController,
                            ),
                            TextFieldWidget(
                              label: "Phone",
                              validator: validatePhone,
                              controller: phoneController,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: width / 1,
                    height: height / 9,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: ProfileDB.userListNotifier,
                            builder: (context, value, _) {
                              if (value.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    handleProfileSaveButtonPress(context);
                                  },
                                  child: const RoundButton(
                                    imagePath:
                                        "asset/imges/navigation_img/eye.png",
                                    label: "Add",
                                    buttonColor: Colors.blue,
                                  ),
                                );
                              } else {
                                return InkWell(
                                  onTap: () {
                                    handleProfileUpdateButtonPress(context);
                                  },
                                  child: const RoundButton(
                                    imagePath:
                                        "asset/imges/navigation_img/eye.png",
                                    label: "Update",
                                    buttonColor: Colors.blue,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const RoundButton(
                          imagePath: "asset/imges/navigation_img/location.png",
                          label: "Delete",
                          buttonColor: Colors.red,
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
                      setState(() {
                        image = img;
                      });
                      _profilePicturePath = image!.path;
                      ProfileDB.userListNotifier.value[0].profilePicturePath =
                          image!.path;
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera"),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      XFile? img = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );
                      setState(() {
                        image = img;
                      });
                      _profilePicturePath = image!.path;
                      ProfileDB.userListNotifier.value[0].profilePicturePath =
                          image!.path;
                      Navigator.pop(context);
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
