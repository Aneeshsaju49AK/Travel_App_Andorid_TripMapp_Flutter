import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class AddPlaceAdmin extends StatefulWidget {
  const AddPlaceAdmin({Key? key}) : super(key: key);

  @override
  State<AddPlaceAdmin> createState() => _AddPlaceAdminState();
}

class _AddPlaceAdminState extends State<AddPlaceAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PlacesDB.instance.reFreshUI();
  }

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width / 1,
          height: height / 1,
          color: Colors.amber,
          child: Column(
            children: [
              const Icon(Icons.back_hand),
              const Text("Addpage"),
              SingleChildScrollView(
                child: Container(
                  width: width / 1,
                  height: height / 1.2,
                  color: Colors.blue,
                  child: ValueListenableBuilder<List<ModelPlace>>(
                    valueListenable: PlacesDB.instance.alappuzhaListNotifier,
                    builder: (context, placeList, _) {
                      print('Number of places: ${placeList.length}');
                      print('Places: $placeList');
                      final one = placeList.toList();
                      print(one[0].district.runtimeType);
                      if (placeList.isNotEmpty) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: placeList.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: width / 2,
                              height: height / 2.5,
                              child: Stack(
                                children: [
                                  placeList[index]
                                          .images![0]
                                          .startsWith("asset/")
                                      ? Image.asset(
                                          placeList[index].images![0],
                                          fit: BoxFit.fill,
                                        )
                                      : Image.file(
                                          File(placeList[index].images![0]),
                                          fit: BoxFit.fill,
                                        ),
                                  Text(placeList[index].placeName!),
                                  IconButton(
                                    onPressed: () {
                                      PlacesDB.instance
                                          .deletePlaces(index)
                                          .then((value) async {
                                        await PlacesDB.instance.reFreshUI();
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 0,
                          itemBuilder: (context, index) {
                            return Container(
                              color: const Color.fromARGB(255, 58, 243, 33),
                              width: width / 2,
                              height: height / 2.5,
                              child: const Text("No value"),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Scaffold(
                  body: SafeArea(
                    child: PopupAddPlace(),
                  ),
                );
              },
            ),
          ).then((value) async {
            await PlacesDB.instance.reFreshUI();
          });
        },
        child: const Text("Add"),
      ),
    );
  }
}

class PopupAddPlace extends StatefulWidget {
  const PopupAddPlace({Key? key}) : super(key: key);

  @override
  State<PopupAddPlace> createState() => _PopupAddPlaceState();
}

class _PopupAddPlaceState extends State<PopupAddPlace> {
  int countImage = 0;
  final List<String> _images = [];
  final districtController = TextEditingController();

  final placeNameController = TextEditingController();
  final subLocationController = TextEditingController();
  final priceController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();
  PlaceCategory? selectedCategory;
  District? selectedDistrict;

  final _formKey = GlobalKey<FormState>();

  String? validateError(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid value";
    }
    return null;
  }

  void handleAddPlaceSaveButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final place = ModelPlace(
        id: DateTime.now().microsecond.toString(),
        district: selectedDistrict,
        category: selectedCategory,
        placeName: placeNameController.text,
        subPlaceName: subLocationController.text,
        price: priceController.text,
        durations: durationController.text,
        description: descriptionController.text,
        images: _images,
      );
      await PlacesDB.instance.insertPlaces(place);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Place added successfully"),
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
                                        _images.removeAt(index);
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
                      onChanged: (District? value) {
                        setState(
                          () {
                            selectedDistrict = value;
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
                      label: "SubLocation",
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
                            handleAddPlaceSaveButtonPress(context);
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
