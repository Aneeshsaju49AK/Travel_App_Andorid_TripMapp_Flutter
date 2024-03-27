import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/controller/firebase_controller/firebase_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

class FirebaseConvert extends StatefulWidget {
  const FirebaseConvert({Key? key}) : super(key: key);

  @override
  State<FirebaseConvert> createState() => _FirebaseConvertState();
}

class _FirebaseConvertState extends State<FirebaseConvert> {
  final CollectionReference places =
      FirebaseFirestore.instance.collection('places');

  final ValueNotifier<List<ModelPlace>> _placeListNotifier =
      ValueNotifier<List<ModelPlace>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Convert'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: places.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final placeList = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          print("hlo ${places.doc().id}");

          // Function to convert Firebase data to List<ModelPlace>
          List<ModelPlace> getPlaceList() {
            return List.generate(
              placeList.length,
              (index) => ModelPlace(
                id: snapshot.data!.docs[index].id,
                district: districtFromString(
                  placeList[index]['selectedDistrict'],
                ),
                category: categoryFromString(
                  placeList[index]['selectedCategory'],
                ),
                placeName: placeList[index]['PlaceName'],
                subPlaceName: placeList[index]['SubName'],
                price: placeList[index]['price'],
                durations: placeList[index]['Duration'],
                description: placeList[index]['Description'],
                images: (placeList[index]['images'] as List<dynamic>)
                    .map((dynamic item) => item.toString())
                    .toList(),
              ),
            );
          }

          // Update the ValueNotifier with the obtained list
          _placeListNotifier.value = getPlaceList();
          ControllerFirebase.instance.fetchPlaces();

          return ValueListenableBuilder(
            valueListenable: ControllerFirebase.instance.lakeCategoryNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  ModelPlace place = value[index];
                  print("${place.id}");
                  return Container(
                    height: 300,
                    width: 300,
                    color: Colors.amber,
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(place.images![0]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Text(place.placeName!),
                    ]),
                  );
                },
              );
            },
          ); // Replace with your UI
        },
      ),
    );
  }

  District? districtFromString(String? districtString) {
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

    return place;
  }
}
