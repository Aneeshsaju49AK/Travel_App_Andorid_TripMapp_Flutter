import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';
import 'package:tripmakerflutterapp/provider/common_page_provider/common_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/details_folder/details_Screen.dart';

/*This widget for build Listview for popular categories */

class PopularListViewWidget extends StatelessWidget {
  final ValueNotifier<List<ModelPlace>> placeListNotifierPopular;
  final void Function(ModelPlace)? onPlaceSelected;
  const PopularListViewWidget({
    required this.placeListNotifierPopular,
    this.onPlaceSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
      valueListenable: placeListNotifierPopular,
      builder: (context, placeList, _) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: placeList.length,
          itemBuilder: (context, index) {
            ModelPlace place = placeList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  onPlaceSelected!(place);
                  Navigator.pop(context);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: width / 4,
                  height: height / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Consumer<CommonProvider>(
                    builder: (context, value, child) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: width / 1,
                            height: height / 1,
                            child: Provider.of<CommonProvider>(context)
                                .getImageWidgetUrl(
                              place.images![0],
                            ),
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
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 30,
                                ),
                                child: FittedBox(
                                  child: SizedBox(
                                    height: 100,
                                    width: 250,
                                    child: SingleChildScrollView(
                                      child: Text(
                                        place.placeName!,
                                        style: GoogleFonts.abel(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsScreen(place: place),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  "asset/imges/approve.png",
                                  scale: 7,
                                  color: Colors.white,
                                ),
                              )
                              // IconButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             DetailsScreen(place: place),
                              //       ),
                              //     );
                              //   },
                              //   icon: const Icon(
                              //     Icons.remove_red_eye_rounded,
                              //     size: 30,
                              //   ),
                              //   color: Colors.white,
                              // ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Widget getImageWidget(String imagePath) {
  //   if (imagePath.startsWith("assets/")) {
  //     return Image.asset(
  //       imagePath,
  //       fit: BoxFit.cover,
  //     );
  //   } else {
  //     return Image.file(
  //       File(imagePath),
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }
}
