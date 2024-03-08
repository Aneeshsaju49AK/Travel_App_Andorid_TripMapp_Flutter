import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripmakerflutterapp/controller/addTrip_model/addTrip_model_controller.dart';
import 'package:tripmakerflutterapp/model/addTrip_model/addTrip_model.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/addtrip_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class ActivityScreenWidget extends StatefulWidget {
  ActivityScreenWidget({super.key});

  @override
  State<ActivityScreenWidget> createState() => _ActivityScreenWidgetState();
}

class _ActivityScreenWidgetState extends State<ActivityScreenWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddtripDB.instance.refreshListUI();
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
          child: Column(
            children: [
              Row(
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
                    label: "Add Trip",
                    divideHeight: 9,
                    divideWidth: 1.2,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: width / 1,
                height: height / 1.3,
                color: Colors.amber,
                child: ValueListenableBuilder(
                  valueListenable: AddtripDB.instance.planTripNotifier,
                  builder: (context, valueList, _) {
                    print("the values on ${valueList.length}");
                    return ListView.builder(
                      itemCount: valueList.length,
                      itemBuilder: (context, index) {
                        TripModel place = valueList[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            width: width / 1,
                            height: height / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.amber,
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
                                    place.selectedPlace!.images![0],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 30,
                                  ),
                                  child: Text(place.selectedPlace!.placeName!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 50,
                                  ),
                                  child: Text(place.name!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 70,
                                  ),
                                  child: Text(place.startDate!.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 90,
                                  ),
                                  child: Text(place.endDate!.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 280,
                                    top: 20,
                                  ),
                                  child: HeartButtonWidget(
                                    sizeOfImage: 40,
                                    place: place.selectedPlace!,
                                    isFavorite: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 120,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      AddtripDB.instance
                                          .deleteAddtrip(index)
                                          .then((value) async {
                                        await AddtripDB.instance
                                            .refreshListUI();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return PopScreenAddTrip();
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

class PopScreenAddTrip extends StatefulWidget {
  const PopScreenAddTrip({super.key});

  @override
  State<PopScreenAddTrip> createState() => _PopScreenAddTripState();
}

class _PopScreenAddTripState extends State<PopScreenAddTrip> {
  final nameController = TextEditingController();
  ModelPlace? place;
  DateTime _startdateTime = DateTime.now();
  DateTime _enddateTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter a valid name";
    }
    return null;
  }

  String? validateDate(DateTime? value) {
    if (value == null) {
      return "please enter a valid ";
    }
    return null;
  }

  void _showDatePicker(bool isStartDate) {
    showDatePicker(
      context: context,
      initialDate: _startdateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    ).then((value) {
      if (value != null) {
        setState(() {
          if (isStartDate) {
            _startdateTime = value;
          } else {
            _enddateTime = value;
          }
        });
      }
    });
  }

  void handleActivitySaveButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final trip = TripModel(
        id: DateTime.now().microsecond.toString(),
        name: nameController.text,
        startDate: _startdateTime,
        endDate: _enddateTime,
        selectedPlace: place,
      );
      await AddtripDB.instance.insertAddtrip(trip);
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width / 1,
        height: height / 2,
        color: Colors.red,
        child: SingleChildScrollView(
          child: Container(
            width: width / 1,
            color: Colors.amber,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.minimize,
                      size: 40,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Add Place",
                      style: GoogleFonts.abel(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTripScreen(
                              onPlace: (selectedPlace) {
                                // Call the onPlace callback function with the selected place
                                setState(() {
                                  place = selectedPlace;
                                });
                                print(
                                    "Selected place on addtirp: ${selectedPlace.placeName}");
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: width / 1.4,
                        height: height / 4,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: width / 1.4,
                              height: height / 4,
                              child: getImageWidget(place?.images?[0] ??
                                  "asset/imges/navigation_img/home-icon-silhouette.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Text("Name your Trip"),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 12,
                    child: TextFormField(
                      validator: validateName,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Select you start date"),
                      SizedBox(
                        width: width / 2.2,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDatePicker(true);
                        },
                        child: Image.asset(
                          "asset/imges/navigation_img/calendar.png",
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 12,
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          _startdateTime.toString(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Select you start date"),
                      SizedBox(
                        width: width / 2.2,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showDatePicker(false);
                        },
                        child: Image.asset(
                          "asset/imges/navigation_img/calendar.png",
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 12,
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          _enddateTime.toString(),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      top: 20,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            handleActivitySaveButtonPress(context);
                          },
                          child: RoundButton(
                            label: "Save",
                            imagePath: "asset/imges/navigation_img/eye.png",
                            buttonColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        RoundButton(
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
