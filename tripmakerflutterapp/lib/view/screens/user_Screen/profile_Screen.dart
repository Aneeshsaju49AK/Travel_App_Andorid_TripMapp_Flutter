import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/user_model/user_model_controllers.dart';
import 'package:tripmakerflutterapp/model/user_model/user_model.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/provider/profile_page_provider.dart';

import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class ProfileSetupWidget extends StatelessWidget {
  ProfileSetupWidget({Key? key}) : super(key: key);

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final userNameController = TextEditingController();

  final phoneController = TextEditingController();

  // String? _profilePicturePath;

  // XFile? image;

  final _formKey = GlobalKey<FormState>();

  // String? validateName(String? value) {
  void handleProfileSaveButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final profile = ProfileModel(
        name: nameController.text,
        email: emailController.text,
        userName: userNameController.text,
        phone: phoneController.text,
        profilePicturePath:
            Provider.of<ProfilePageProvider>(context, listen: false)
                .profilePicturePath,
      );
      await addValue(profile);

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
                      child: Consumer<ProfilePageProvider>(
                        builder: (context, value, child) {
                          return CircleAvatarWidget(
                            radius: 80,
                            islocationwidget: true,
                            imagePath: value.profilePicturePath,
                            onpressed: () {
                              value.buttomSheet(context, false);
                            },
                          );
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
                          child: InkWell(
                            onTap: () {
                              handleProfileSaveButtonPress(context);
                            },
                            child: const RoundButton(
                              imagePath: "asset/imges/navigation_img/eye.png",
                              label: "Add",
                              buttonColor: Colors.blue,
                            ),
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
