import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

class ProfilePageProvider extends ChangeNotifier {
  String? _profilePicturePath;
  List<String> _images = [];
  late ModelPlace places;
  final districtController = TextEditingController();
  final placeNameController = TextEditingController();
  final subLocationController = TextEditingController();
  final priceController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();
  PlaceCategory? selectedCategory;
  District? selectedDistrict;

  // List<String> links() => images;
  int countImage = 0;

  void initModelPlace(ModelPlace currentPlace) {
    places = currentPlace;
    _images = currentPlace.images!;
    countImage = _images.length;
    placeNameController.text = currentPlace.placeName ?? '';
    subLocationController.text = currentPlace.subPlaceName ?? '';
    priceController.text = currentPlace.price ?? '';
    durationController.text = currentPlace.durations ?? '';
    descriptionController.text = currentPlace.description ?? '';
    selectedDistrict = currentPlace.district;
    selectedCategory = currentPlace.category;
    notifyListeners();
  }

  void decreaseCount(int index) {
    _images.removeAt(index);
    notifyListeners();
    countImage--;
    notifyListeners();
  }

  void increament() {
    countImage++;
    notifyListeners();
  }

  void addImage(String imagePath) {
    _images.add(imagePath);
    notifyListeners();
  }

  PlaceCategory? _selectedPlaceCategoty;
  District? _selectedDistrict;

  PlaceCategory? get place => _selectedPlaceCategoty;
  void onchagedCategory(PlaceCategory? value) {
    _selectedPlaceCategoty = value;
    notifyListeners();
  }

  District? get district => _selectedDistrict;
  void onchagedDistrict(District? value) {
    _selectedDistrict = value;
    notifyListeners();
  }

  String? get profilePicturePath => _profilePicturePath;
  List<String> get images {
    notifyListeners();
    return _images;
  }

  XFile? image;

  buttomSheet(BuildContext context, bool isList) {
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
                      // image = img;
                      if (isList == true) {
                        if (img != null) {
                          addImage(img.path);
                        }
                      } else {
                        if (img != null) {
                          _profilePicturePath = img.path;
                        }
                      }

                      // setState(() {
                      //   image = img;
                      // });
                      // _profilePicturePath = img!.path;
                      notifyListeners();
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

                      if (isList == true) {
                        if (img != null) {
                          addImage(img.path);
                        }
                      } else {
                        if (img != null) {
                          _profilePicturePath = img.path;
                        }
                      }
                      // image = img;
                      // setState(() {
                      //   image = img;
                      // });
                      // if (img != null) {
                      //   addImage(img.path);
                      // }
                      // _profilePicturePath = img!.path;
                      notifyListeners();
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
