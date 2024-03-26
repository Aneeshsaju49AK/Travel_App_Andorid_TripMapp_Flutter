import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/addTrip_model/addTrip_model_controller.dart';
import 'package:tripmakerflutterapp/model/addTrip_model/addTrip_model.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/activity_page_provider.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';

import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';

import 'package:tripmakerflutterapp/view/screens/user_Screen/addtrip_Screen.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/headWwite_widget/headwrite_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/heartButton_folder/heartbutton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/roundButton_folder/roundButton_widget.dart';

import '../../widget/common_widget/populatList_folder/commonwidget.dart';

class ActivityScreenWidget extends StatelessWidget {
  const ActivityScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ActivityPageProvider>(context).reFreshListUI();
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
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: width / 1,
                height: height / 1.3,
                child: ValueListenableBuilder(
                  valueListenable: AddtripDB.instance.planTripNotifier,
                  builder: (context, valueList, _) {
                    if (valueList.isEmpty) {
                      return Center(
                        child: Text(
                          "No trip is planned",
                          style: GoogleFonts.abel(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: valueList.length,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        TripModel place = valueList[index];

                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            width: width / 1,
                            height: height / 3.5,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Consumer<CommonProvider>(
                                  builder: (context, value, child) {
                                    return SizedBox(
                                      width: width / 1,
                                      height: height / 3.5,
                                      child: value.getImageWidget(
                                        place.selectedPlace!.images![0],
                                      ),
                                    );
                                  },
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: height / 7,
                                  left: 50,
                                  child: SizedBox(
                                    width: width / 1.5,
                                    child: FittedBox(
                                        child: Container(
                                      height: 200,
                                      width: 200,
                                      child: Text(
                                        place.selectedPlace!.placeName!,
                                        style: GoogleFonts.abel(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                                Positioned(
                                  top: height / 5.5,
                                  left: 50,
                                  child: SizedBox(
                                    width: width / 1.5,
                                    child: FittedBox(
                                        child: Container(
                                      height: 200,
                                      width: 200,
                                      child: Text(
                                        place.name!,
                                        style: GoogleFonts.abel(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )),
                                  ),
                                ),
                                // Text(place.startDate!.toString()),
                                Positioned(
                                  top: height / 4.5,
                                  child: SizedBox(
                                    width: width / 2,
                                    height: height / 35,
                                    child: FittedBox(
                                        child: Text(
                                      place.startDate!
                                          .toString()
                                          .substring(0, 10),
                                      style: GoogleFonts.abel(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                  ),
                                ),
                                Positioned(
                                  top: height / 4,
                                  child: SizedBox(
                                    width: width / 2,
                                    height: height / 35,
                                    child: FittedBox(
                                        child: Text(
                                      place.endDate!
                                          .toString()
                                          .substring(0, 10),
                                      style: GoogleFonts.abel(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                                  ),
                                ),
                                Positioned(
                                  left: width / 1.7,
                                  top: height / 30,
                                  child: Row(
                                    children: [
                                      HeartButtonWidget(
                                        sizeOfImage: 40,
                                        place: place.selectedPlace!,
                                        isFavorite: true,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Logout"),
                                                content: const Text(
                                                    "Are you sure you want to remove Trip?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("No"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      AddtripDB.instance
                                                          .deleteAddtrip(
                                                              place.id)
                                                          .then(
                                                        (value) {
                                                          AddtripDB.instance
                                                              .refreshListUI();
                                                        },
                                                      );
                                                    },
                                                    child: const Text("Yes"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
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
        onPressed: () => showBottomSheet(
          context: context,
          builder: (context) {
            return PopScreenAddTrip();
          },
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class PopScreenAddTrip extends StatelessWidget {
  PopScreenAddTrip({super.key});

  final nameController = TextEditingController();

  ModelPlace? place;

  // DateTime _startdateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  // String? validateName(String? value) {
  void handleActivitySaveButtonPress(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final trip = TripModel(
        id: DateTime.now().microsecond.toString(),
        name: nameController.text,
        startDate:
            Provider.of<ActivityPageProvider>(context, listen: false).startDate,
        endDate:
            Provider.of<ActivityPageProvider>(context, listen: false).endDate,
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
    final authProviderCommonProvider = Provider.of<CommonProvider>(context);
    return Consumer<ActivityPageProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width / 1,
            color: Provider.of<DarkModeProvider>(context).value
                ? const Color.fromARGB(255, 33, 39, 43)
                : const Color.fromARGB(255, 230, 234, 212),
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
                  SizedBox(
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
                                place = value.setStateModelPlace(selectedPlace);
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
                              child: authProviderCommonProvider.getImageWidget(
                                place?.images?.isEmpty ?? true
                                    ? "asset/imges/pexels-photo-4220967.jpeg"
                                    : place!.images![0],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Name your Trip",
                  ),
                  SizedBox(
                    width: width / 1.2,
                    height: height / 12,
                    child: TextFormField(
                      validator: authProviderCommonProvider.validateValue,
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
                      const Text(
                        "Select you start date",
                      ),
                      SizedBox(
                        width: width / 2.2,
                      ),
                      GestureDetector(
                        onTap: () {
                          value.showDatePickerUI(
                            true,
                            context,
                          );
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
                          value.startDate.toString(),
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
                          value.showDatePickerUI(false, context);
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
                          value.endDate.toString(),
                        ),
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
                            handleActivitySaveButtonPress(context);
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
        );
      },
    );
  }
}
