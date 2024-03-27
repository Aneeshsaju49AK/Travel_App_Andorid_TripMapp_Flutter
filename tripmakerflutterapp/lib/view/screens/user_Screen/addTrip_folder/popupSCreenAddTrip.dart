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
import 'package:tripmakerflutterapp/view/widget/common_widget/roundButton_folder/roundButton_widget.dart';

class PopScreenAddTrip extends StatefulWidget {
  PopScreenAddTrip({super.key});

  @override
  State<PopScreenAddTrip> createState() => _PopScreenAddTripState();
}

class _PopScreenAddTripState extends State<PopScreenAddTrip> {
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
        return Container(
          width: width / 1,
          color: Provider.of<DarkModeProvider>(context).value
              ? const Color.fromARGB(255, 33, 39, 43)
              : const Color.fromARGB(255, 230, 234, 212),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                              child:
                                  authProviderCommonProvider.getImageWidgetUrl(
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
                  Text(
                    "Name your Trip",
                    style: GoogleFonts.abel(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
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
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Select you start date",
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: width / 2.8,
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
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Select you start date",
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: width / 2.8,
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
                      left: 22.5,
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
                            imagePath:
                                "asset/imges/navigation_img/home-icon-silhouette.png",
                            buttonColor: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {
                            nameController.text = "";
                          },
                          child: const RoundButton(
                            label: "Clear",
                            imagePath: "asset/imges/navigation_img/eye.png",
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
        );
      },
    );
  }
}
