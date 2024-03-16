import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class Updatepage_placeModel extends StatefulWidget {
  final ModelPlace place;
  const Updatepage_placeModel({required this.place, Key? key})
      : super(key: key);

  @override
  State<Updatepage_placeModel> createState() => _Updatepage_placeModelState();
}

class _Updatepage_placeModelState extends State<Updatepage_placeModel> {
  int countImage = 0;
  late ModelPlace _currentPlace;
  final List<String> _images = [];
  final districtController = TextEditingController();
  final placeNameController = TextEditingController();
  final subLocationController = TextEditingController();
  final priceController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();
  PlaceCategory? selectedCategory;
  District? selectedDistrict;

  @override
  void initState() {
    super.initState();
    _currentPlace = widget.place;

    _images.addAll(_currentPlace.images ?? []);
    countImage = _images.length;
    placeNameController.text = _currentPlace.placeName ?? '';
    subLocationController.text = _currentPlace.subPlaceName ?? '';
    priceController.text = _currentPlace.price ?? '';
    durationController.text = _currentPlace.durations ?? '';
    descriptionController.text = _currentPlace.description ?? '';
    selectedDistrict = _currentPlace.district;
    selectedCategory = _currentPlace.category;
  }

  final _formKey = GlobalKey<FormState>();

  String? validateError(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid value";
    }
    return null;
  }

  void handleUpdatePlaceSaveButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final place = ModelPlace(
        id: _currentPlace.id,
        district: selectedDistrict,
        category: selectedCategory,
        placeName: placeNameController.text,
        subPlaceName: subLocationController.text,
        price: priceController.text,
        durations: durationController.text,
        description: descriptionController.text,
        images: _images,
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

  @override
  Widget build(BuildContext context) {
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
                      "Add place",
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
                                        _images.remove(index);
                                        countImage--;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      buttomSheet(context);
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
                      setState(() {
                        countImage++;
                      });
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
                      value: selectedDistrict,
                      onChanged: (District? newvalue) {
                        setState(
                          () {
                            selectedDistrict = newvalue;
                          },
                        );
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
                      value: selectedCategory,
                      onChanged: (PlaceCategory? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
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
                      controller: placeNameController,
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
                      controller: subLocationController,
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
                      controller: priceController,
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
                      controller: durationController,
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
                      controller: descriptionController,
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
