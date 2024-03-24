import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/profile_page_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';

import '../../widget/common_widget/backButton_folder/backButton_widget.dart';
import '../../widget/common_widget/populatList_folder/commonwidget.dart';

class ProfileSetupWidget extends StatelessWidget {
  ProfileSetupWidget({Key? key}) : super(key: key);

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final userNameController = TextEditingController();

  final phoneController = TextEditingController();

  // String? _profilePicturePath;

  // XFile? image;

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
      final profile = ProfileModels(
        id: ProfileDB.userListNotifier.value[0].id,
        name: nameController.text,
        email: emailController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        // profilePicturePath: _profilePicturePath ??
        //     ProfileDB.userListNotifier.value[0].profilePicturePath,
        // profilePicturePath: _profilePicturePath ,??
        //     ProfileDB.userListNotifier.value[0].profilePicturePath,
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
      final profile = ProfileModels(
        id: DateTime.now().microsecond.toInt(),
        name: nameController.text,
        email: emailController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        profilePicturePath:
            Provider.of<ProfilePageProvider>(context, listen: false)
                .profilePicturePath,
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
    final authProviderCommon =
        Provider.of<CommonProvider>(context, listen: false);
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
                    child: Row(
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
                              // onpressed: () {
                              //   buttomSheet(context);
                              // },
                            );
                          } else {
                            return CircleAvatarWidget(
                              radius: 80,
                              islocationwidget: true,
                              // imagePath: _profilePicturePath,
                              // onpressed: () {
                              //   buttomSheet(context);
                              // },
                            );
                          }
                        },
                        // child: CircleAvatarWidget(
                        //   radius: 80,
                        //   islocationwidget: true,
                        //   imagePath: _profilePicturePath,
                        //   onpressed: () {
                        //     buttomSheet(context);
                        //   },
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width / 1,
                    height: height / 1.7,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          label: "Name",
                          validator: authProviderCommon.validateValue,
                          controller: nameController,
                          onChange: () {
                            if (_formKey.currentState?.validate() == false) {
                              _formKey.currentState?.reset();
                            }
                          },
                        ),
                        TextFieldWidget(
                          label: "Email",
                          validator: authProviderCommon.validateValue,
                          controller: emailController,
                        ),
                        TextFieldWidget(
                          label: "User Name",
                          validator: authProviderCommon.validateValue,
                          controller: userNameController,
                        ),
                        TextFieldWidget(
                          label: "Phone",
                          validator: authProviderCommon.validateValue,
                          controller: phoneController,
                        ),
                      ],
                    ),
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
                        InkWell(
                          onTap: () {
                            nameController.text = "";
                            emailController.text = "";
                            userNameController.text = "";
                            phoneController.text = "";
                          },
                          child: const RoundButton(
                            imagePath:
                                "asset/imges/navigation_img/location.png",
                            label: "clear",
                            buttonColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
