import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/provider/maplocation_page_provider/maplocation_provider.dart';

class MapLocation extends StatelessWidget {
  final bool? islocationWidget;
  final Position? location;
  final String? locationName;
  const MapLocation({
    this.islocationWidget,
    this.location,
    this.locationName,
    Key? key,
  }) : super(key: key);

//  final bool showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MapLocationProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            value.changeValue();
            // setState(() {
            //   showFullText = !showFullText;
            // });
          },
          child: Container(
            child: islocationWidget == true && location != null
                ? Text(
                    value.showFullText
                        ? "$locationName"
                        : "${locationName!.substring(0, 10)}...", // Display only the first 10 characters
                  )
                : const Text("Location not available"),
          ),
        );
      },
      // child: Container(
      //   child: widget.islocationWidget == true && widget.location != null
      //       ? Text(
      //           showFullText
      //               ? "${widget.locationName}"
      //               : "${widget.locationName!.substring(0, 10)}...", // Display only the first 10 characters
      //         )
      //       : const Text("Location not available"),
      // ),
    );
  }
}
