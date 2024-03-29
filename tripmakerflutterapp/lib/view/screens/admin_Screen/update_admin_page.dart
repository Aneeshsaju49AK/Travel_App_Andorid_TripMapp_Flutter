import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/roundButton_folder/roundButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/texiField_widget/textfield_widget.dart';

class PlaceUpdateFirebase extends StatefulWidget {
  final Map<String, dynamic> placeData;
  final dynamic id;
  const PlaceUpdateFirebase(
      {required this.id, required this.placeData, Key? key})
      : super(key: key);

  @override
  State<PlaceUpdateFirebase> createState() => _PlaceUpdateFirebaseState();
}

class _PlaceUpdateFirebaseState extends State<PlaceUpdateFirebase> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final CollectionReference places =
      FirebaseFirestore.instance.collection('places');
  int countImage = 0;

  final List<String> _images = [];

  final List<String> imagesList = [];

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

  @override
  void initState() {
    super.initState();
    print(widget.placeData);
    print(widget.id);
    final dynamic imagesData = widget.placeData['images'];
    if (imagesData != null && imagesData is Iterable) {
      // Iterate over each element and add it to the imagesList after converting it to a string
      imagesList.addAll(imagesData.map((e) => e.toString()));
    }
    _images.addAll(imagesList);
    print(_images.length);
    countImage = _images.length;

    // Populate the TextEditingControllers with data from the widget.placeData map
    placeNameController.text = widget.placeData['PlaceName'] ?? '';
    subLocationController.text = widget.placeData['SubName'] ?? '';
    priceController.text = widget.placeData['price'] ?? '';
    durationController.text = widget.placeData['Duration'] ?? '';
    descriptionController.text = widget.placeData['Description'] ?? '';
    // Set selectedDistrict and selectedCategory if applicable
    // For example:
    selectedDistrict = districtFromString(widget.placeData['selectedDistrict']);
    selectedCategory = categoryFromString(widget.placeData['selectedCategory']);
    // Populate _images list with images from widget.placeData if needed
    // For example:
    // _images.addAll((widget.placeData['images'] as List<String>) ?? []);
  }

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
                                          image: index < imagesList.length
                                              ? NetworkImage(imagesList[index])
                                              : FileImage(File(_images[index]))
                                                  as ImageProvider<Object>,
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
                                            countImage = _images.length;
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
                          print(_images.length);
                          setState(() {
                            countImage++;
                            print(_images.length);
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
                                child:
                                    Text(district.toString().split('.').last),
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
                                child:
                                    Text(category.toString().split('.').last),
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
                                print(widget.placeData);
                                handleAddPlaceUpdateButtonPress(
                                  context,
                                );
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

  District? districtFromString(String? districtString) {
    print(districtString);
    switch (districtString) {
      case 'District.Alappuzha':
        return District.Alappuzha;
      case 'District.Ernakulam':
        return District.Ernakulam;
      case 'District.Idukki':
        return District.Idukki;
      case 'District.Kannur':
        return District.Kannur;
      case 'District.Kasargode':
        return District.Kasargode;
      case 'District.Kollam':
        return District.Kollam;
      case 'District.Kottayam':
        return District.Kottayam;
      case 'District.Kozhikode':
        return District.Kozhikode;
      case 'District.Malappuram':
        return District.Malappuram;
      case 'District.Palakkadu':
        return District.Palakkadu;
      case 'District.Pathanamthitta':
        return District.Pathanamthitta;
      case 'District.Thrissur':
        return District.Thrissur;
      case 'District.Trivandram':
        return District.Trivandram;
      case 'District.Wayanad':
        return District.Wayanad;
      default:
        print('Unknown category: $districtString');
        break;
    }
    return null;
  }

  PlaceCategory? categoryFromString(String catogoryString) {
    print(catogoryString);
    PlaceCategory? place;
    switch (catogoryString) {
      case 'PlaceCategory.hillStations':
        return PlaceCategory.hillStations;

      case "PlaceCategory.monuments":
        return PlaceCategory.monuments;

      case 'PlaceCategory.waterfalls':
        return PlaceCategory.waterfalls;

      case 'PlaceCategory.forests':
        return PlaceCategory.forests;

      case 'PlaceCategory.beaches':
        return PlaceCategory.beaches;

      case 'PlaceCategory.lake':
        return PlaceCategory.lake;

      default:
        print('Unknown category: $catogoryString');
        break;
    }
    print(place);
    return place;
  }

  void handleAddPlaceUpdateButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      List<String> uploadedImageUrls = [];
      // Upload each image to Firebase storage
      for (String imagePath in _images) {
        try {
          final String fileName = basename(imagePath);
          final ref = storage.ref().child('placeImages/$fileName');
          final uploadTask = ref.putFile(File(imagePath));
          final downloadUrl = await uploadTask;
          final String imageUrl = await downloadUrl.ref.getDownloadURL();
          uploadedImageUrls.add(imageUrl);
        } catch (e) {
          print('Error uploading image: $e');
        }
      }

      if (imagesList.isNotEmpty) {
        uploadedImageUrls.addAll(imagesList);
      }

      // Save place details with uploaded image URLs
      final Place = {
        'PlaceName': placeNameController.text,
        'SubName': subLocationController.text,
        'price': priceController.text,
        'selectedCategory': selectedCategory.toString(),
        'selectedDistrict': selectedDistrict.toString(),
        'Duration': durationController.text,
        'Description': descriptionController.text,
        'images': uploadedImageUrls,
      };

      try {
        // await places.add(Place);
        await places.doc(widget.id).update(Place);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Place added successfully"),
            backgroundColor: Colors.green[200],
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error saving place details: $e');
      }
    }
  }
}
