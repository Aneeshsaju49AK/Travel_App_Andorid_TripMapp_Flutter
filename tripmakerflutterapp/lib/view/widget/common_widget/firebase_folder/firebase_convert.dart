import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  //  static ValueNotifier<List<ModelPlace>> favoriteListNotifier =
  // ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> placeListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> hillStationCatrgoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> momumentsCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> waterfallsCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> forestsCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> beachCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> desertsCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> alappuzhaListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> ernakulamListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> idukkiListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kannurListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kasargodeListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kollamListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kottayamListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> kozhikodeListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> malappuramListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> palakkaduListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> pathanamthittaListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> trissurListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> trivanramListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> wayanadListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> commonDistrictListNotifier =
      ValueNotifier([]);

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

          // Function to convert Firebase data to List<ModelPlace>
          List<ModelPlace> getPlaceList() {
            return List.generate(
                placeList.length,
                (index) => ModelPlace(
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
                    ));
          }

          // Update the ValueNotifier with the obtained list
          _placeListNotifier.value = getPlaceList();
          Future<void> reFreshUI() async {
            final allPlaces = await getPlaceList();
            placeListNotifier.value.clear();
            hillStationCatrgoryListNotifier.value.clear();
            desertsCategoryNotifier.value.clear();
            forestsCategoryNotifier.value.clear();
            momumentsCategoryListNotifier.value.clear();
            waterfallsCategoryListNotifier.value.clear();
            beachCategoryNotifier.value.clear();
            await Future.forEach(
              allPlaces,
              (ModelPlace place) {
                placeListNotifier.value.add(place);
                if (place.category != null) {
                  if (place.category == PlaceCategory.hillStations) {
                    hillStationCatrgoryListNotifier.value.add(place);
                  } else if (place.category == PlaceCategory.lake) {
                    desertsCategoryNotifier.value.add(place);
                  } else if (place.category == PlaceCategory.forests) {
                    forestsCategoryNotifier.value.add(place);
                  } else if (place.category == PlaceCategory.monuments) {
                    momumentsCategoryListNotifier.value.add(place);
                  } else if (place.category == PlaceCategory.waterfalls) {
                    waterfallsCategoryListNotifier.value.add(place);
                  } else if (place.category == PlaceCategory.beaches) {
                    beachCategoryNotifier.value.add(place);
                  }
                }
              },
            );
            placeListNotifier.notifyListeners();
            hillStationCatrgoryListNotifier.notifyListeners();
            desertsCategoryNotifier.notifyListeners();
            forestsCategoryNotifier.notifyListeners();
            momumentsCategoryListNotifier.notifyListeners();
            waterfallsCategoryListNotifier.notifyListeners();
            beachCategoryNotifier.notifyListeners();

            alappuzhaListNotifier.value.clear();
            ernakulamListNotifier.value.clear();
            idukkiListNotifier.value.clear();
            kannurListNotifier.value.clear();
            kasargodeListNotifier.value.clear();
            kollamListNotifier.value.clear();
            kozhikodeListNotifier.value.clear();
            malappuramListNotifier.value.clear();
            palakkaduListNotifier.value.clear();
            pathanamthittaListNotifier.value.clear();
            trissurListNotifier.value.clear();
            trivanramListNotifier.value.clear();
            wayanadListNotifier.value.clear();
            commonDistrictListNotifier.value.clear();
            await Future.forEach(
              allPlaces,
              (ModelPlace place) {
                if (place.district == District.Alappuzha) {
                  alappuzhaListNotifier.value.add(place);
                } else if (place.district == District.Ernakulam) {
                  ernakulamListNotifier.value.add(place);
                } else if (place.district == District.Idukki) {
                  idukkiListNotifier.value.add(place);
                } else if (place.district == District.Kannur) {
                  kannurListNotifier.value.add(place);
                } else if (place.district == District.Kasargode) {
                  kasargodeListNotifier.value.add(place);
                } else if (place.district == District.Kollam) {
                  kollamListNotifier.value.add(place);
                } else if (place.district == District.Kottayam) {
                  kottayamListNotifier.value.add(place);
                } else if (place.district == District.Kozhikode) {
                  kozhikodeListNotifier.value.add(place);
                } else if (place.district == District.Malappuram) {
                  malappuramListNotifier.value.add(place);
                } else if (place.district == District.Palakkadu) {
                  palakkaduListNotifier.value.add(place);
                } else if (place.district == District.Pathanamthitta) {
                  pathanamthittaListNotifier.value.add(place);
                } else if (place.district == District.Thrissur) {
                  trissurListNotifier.value.add(place);
                } else if (place.district == District.Trivandram) {
                  trivanramListNotifier.value.add(place);
                } else if (place.district == District.Wayanad) {
                  wayanadListNotifier.value.add(place);
                } else {
                  commonDistrictListNotifier.value.add(place);
                }
              },
            );
            alappuzhaListNotifier.notifyListeners();
            ernakulamListNotifier.notifyListeners();
            idukkiListNotifier.notifyListeners();
            kannurListNotifier.notifyListeners();
            kasargodeListNotifier.notifyListeners();
            kollamListNotifier.notifyListeners();
            kottayamListNotifier.notifyListeners();
            kozhikodeListNotifier.notifyListeners();
            malappuramListNotifier.notifyListeners();
            palakkaduListNotifier.notifyListeners();
            pathanamthittaListNotifier.notifyListeners();
            trissurListNotifier.notifyListeners();
            wayanadListNotifier.notifyListeners();
            trivanramListNotifier.notifyListeners();
            commonDistrictListNotifier.notifyListeners();
          }

          return ValueListenableBuilder(
            valueListenable: _placeListNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  ModelPlace place = value[index];
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
}
