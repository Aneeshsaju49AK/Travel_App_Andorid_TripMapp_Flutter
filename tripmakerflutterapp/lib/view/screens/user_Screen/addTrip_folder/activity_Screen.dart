import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/addTrip_model/addTrip_model_controller.dart';
import 'package:tripmakerflutterapp/model/addTrip_model/addTrip_model.dart';
import 'package:tripmakerflutterapp/provider/activity_page_provider/activity_page_provider.dart';
import 'package:tripmakerflutterapp/provider/common_page_provider/common_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/addTrip_folder/popupSCreenAddTrip.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/backButton_folder/backButton_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/headWwite_widget/headwrite_widget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/heartButton_folder/heartbutton_widget.dart';

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
                        child: Column(
                          children: [
                            Text(
                              "No trip is planned",
                              style: GoogleFonts.abel(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Image.asset(
                              "asset/imges/emoji.png",
                              scale: 3,
                            ),
                          ],
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
                                      child: value.getImageWidgetUrl(
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
                                        child: SizedBox(
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
                                        child: SizedBox(
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
