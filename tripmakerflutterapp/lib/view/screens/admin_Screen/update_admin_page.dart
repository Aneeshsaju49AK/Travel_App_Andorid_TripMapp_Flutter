import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/profile_page_provider.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/roundButton_folder/roundButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/texiField_widget/textfield_widget.dart';

import '../../widget/common_widget/populatList_folder/commonwidget.dart';

class UpdatepageplaceModel extends StatelessWidget {
  final ModelPlace place;
  UpdatepageplaceModel({required this.place, Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String? validateError(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid value";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authProfileProvider = Provider.of<ProfilePageProvider>(
      context,
      listen: false,
    );
    authProfileProvider.initModelPlace(place);
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width / 1,
      height: height / 1,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: width / 1,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.minimize),
                  ),
                  SizedBox(
                    child: Text(
                      "Edit place",
                      style: GoogleFonts.abel(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Consumer<ProfilePageProvider>(
                    builder: (context, value, child) {
                      return Column(
                        children: List.generate(
                          authProfileProvider.countImage,
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
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          value.buttomSheet(context, true);
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
                      );
                    },
                  ),
                  TextButton.icon(
                    onPressed: () {
                      authProfileProvider.increament();
                    },
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text("Add Image"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 7,
                    child: DropdownButtonFormField<District>(
                      items: District.values.map(
                        (District district) {
                          return DropdownMenuItem<District>(
                            value: district,
                            child: Text(district.toString().split('.').last),
                          );
                        },
                      ).toList(),
                      validator: (value) {
                        if (value == null) {
                          return "Please select a district";
                        }
                        return null;
                      },
                      value: authProfileProvider.selectedDistrict,
                      onChanged: (District? newvalue) {
                        authProfileProvider.onchagedDistrict(newvalue);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 7,
                    child: DropdownButtonFormField<PlaceCategory>(
                      items: PlaceCategory.values.map(
                        (PlaceCategory category) {
                          return DropdownMenuItem<PlaceCategory>(
                            value: category,
                            child: Text(category.toString().split('.').last),
                          );
                        },
                      ).toList(),
                      validator: (value) {
                        if (value == null) {
                          return "Please select a category";
                        }
                        return null;
                      },
                      value: authProfileProvider.selectedCategory,
                      onChanged: (PlaceCategory? newValue) {
                        authProfileProvider.onchagedCategory(newValue);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 7,
                    child: TextFieldWidget(
                      label: "PlaceName",
                      controller: authProfileProvider.placeNameController,
                      validator: validateError,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 7,
                    child: TextFieldWidget(
                      label: "subname",
                      controller: authProfileProvider.subLocationController,
                      validator: validateError,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 7,
                    child: TextFieldWidget(
                      label: "Price",
                      controller: authProfileProvider.priceController,
                      validator: validateError,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 7,
                    child: TextFieldWidget(
                      label: "Durations",
                      controller: authProfileProvider.durationController,
                      validator: validateError,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Description"),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 4,
                    child: TextFormField(
                      controller: authProfileProvider.descriptionController,
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
                            handleUpdatePlaceSaveButtonPress(context);
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
      ),
    );
  }

  void handleUpdatePlaceSaveButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final profileProvider = Provider.of<ProfilePageProvider>(
        context,
        listen: false,
      );
      final place = ModelPlace(
        id: profileProvider.places.id,
        district: profileProvider.district,
        category: profileProvider.place,
        placeName: profileProvider.placeNameController.text,
        subPlaceName: profileProvider.subLocationController.text,
        price: profileProvider.priceController.text,
        durations: profileProvider.durationController.text,
        description: profileProvider.descriptionController.text,
        images: profileProvider.images,
      );
      await PlacesDB.instance
          .updatePlace(place)
          .then((value) => PlacesDB.instance.reFreshUI());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Place updated successfully"),
          backgroundColor: Colors.green[200],
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
  }
}
