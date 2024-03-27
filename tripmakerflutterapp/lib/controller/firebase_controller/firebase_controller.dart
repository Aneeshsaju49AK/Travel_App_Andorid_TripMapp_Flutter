import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

class ControllerFirebase {
  ControllerFirebase._internal();

  static ControllerFirebase instance = ControllerFirebase._internal();

  factory ControllerFirebase() {
    return instance;
  }
  final CollectionReference places =
      FirebaseFirestore.instance.collection('places');

  final ValueNotifier<List<ModelPlace>> placeListNotifier01 =
      ValueNotifier<List<ModelPlace>>([]);
  //  static ValueNotifier<List<ModelPlace>> favoriteListNotifier =
  // ValueNotifier([]);
  static ValueNotifier<List<ModelPlace>> placeListNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> hillStationCatrgoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> momumentsCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> waterfallsCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> forestsCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> beachCategoryNotifier = ValueNotifier([]);
  ValueNotifier<List<ModelPlace>> lakeCategoryNotifier = ValueNotifier([]);
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

  Future<void> fetchPlaces() async {
    try {
      QuerySnapshot querySnapshot = await places.get();
      List<ModelPlace> placesList = [];
      List<ModelPlace> alappuzhaplacesList = [];
      List<ModelPlace> ernakulamplacesList = [];
      List<ModelPlace> idukkiplacesList = [];
      List<ModelPlace> kannurplacesList = [];
      List<ModelPlace> kasargodeplacesList = [];
      List<ModelPlace> kollamplacesList = [];
      List<ModelPlace> kottayamplacesList = [];
      List<ModelPlace> kozhikodeplacesList = [];
      List<ModelPlace> malappuramplacesList = [];
      List<ModelPlace> palakkaduplacesList = [];
      List<ModelPlace> pathanamthittaplacesList = [];
      List<ModelPlace> thrissurplacesList = [];
      List<ModelPlace> trivandramplacesList = [];
      List<ModelPlace> wayanadplacesList = [];
      List<ModelPlace> commonplacesList = [];
      List<ModelPlace> hillStationsplacesList = [];
      List<ModelPlace> monumentsplacesList = [];
      List<ModelPlace> waterfallsplacesList = [];
      List<ModelPlace> forestsplacesList = [];
      List<ModelPlace> beachesplacesList = [];
      List<ModelPlace> lakeplacesList = [];

      querySnapshot.docs.forEach(
        (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          ModelPlace place = ModelPlace(
            id: doc.id,
            district: districtFromString(data['selectedDistrict']),
            category: categoryFromString(data['selectedCategory']),
            placeName: data['PlaceName'],
            subPlaceName: data['SubName'],
            price: data['price'],
            durations: data['Duration'],
            description: data['Description'],
            images: (data['images'] as List<dynamic>)
                .map((item) => item.toString())
                .toList(),
          );
          print(place.id);
          placesList.add(place);
          if (place.district == District.Alappuzha) {
            alappuzhaplacesList.add(place);
          } else if (place.district == District.Ernakulam) {
            ernakulamplacesList.add(place);
          } else if (place.district == District.Idukki) {
            idukkiplacesList.add(place);
          } else if (place.district == District.Kannur) {
            kannurplacesList.add(place);
          } else if (place.district == District.Kasargode) {
            kasargodeplacesList.add(place);
          } else if (place.district == District.Kollam) {
            kollamplacesList.add(place);
          } else if (place.district == District.Kottayam) {
            kottayamplacesList.add(place);
          } else if (place.district == District.Kozhikode) {
            kozhikodeplacesList.add(place);
          } else if (place.district == District.Malappuram) {
            malappuramplacesList.add(place);
          } else if (place.district == District.Palakkadu) {
            palakkaduplacesList.add(place);
          } else if (place.district == District.Pathanamthitta) {
            pathanamthittaplacesList.add(place);
          } else if (place.district == District.Thrissur) {
            thrissurplacesList.add(place);
          } else if (place.district == District.Trivandram) {
            trivandramplacesList.add(place);
          } else if (place.district == District.Wayanad) {
            wayanadplacesList.add(place);
          } else {
            commonplacesList.add(place);
          }

          if (place.category == PlaceCategory.beaches) {
            beachesplacesList.add(place);
          } else if (place.category == PlaceCategory.forests) {
            forestsplacesList.add(place);
          } else if (place.category == PlaceCategory.hillStations) {
            hillStationsplacesList.add(place);
          } else if (place.category == PlaceCategory.lake) {
            lakeplacesList.add(place);
          } else if (place.category == PlaceCategory.monuments) {
            monumentsplacesList.add(place);
          } else if (place.category == PlaceCategory.waterfalls) {
            waterfallsplacesList.add(place);
          }
        },
      );

      // Update the ValueNotifier with the obtained list
      placeListNotifier.value = placesList;
      placeListNotifier.notifyListeners();
      alappuzhaListNotifier.value = alappuzhaplacesList;
      alappuzhaListNotifier.notifyListeners();
      ernakulamListNotifier.value = ernakulamplacesList;
      ernakulamListNotifier.notifyListeners();
      idukkiListNotifier.value = idukkiplacesList;
      idukkiListNotifier.notifyListeners();
      kannurListNotifier.value = kannurplacesList;
      kannurListNotifier.notifyListeners();
      kasargodeListNotifier.value = kasargodeplacesList;
      kasargodeListNotifier.notifyListeners();
      kollamListNotifier.value = kollamplacesList;
      kollamListNotifier.notifyListeners();
      kottayamListNotifier.value = kottayamplacesList;
      kottayamListNotifier.notifyListeners();
      kozhikodeListNotifier.value = kozhikodeplacesList;
      kozhikodeListNotifier.notifyListeners();
      malappuramListNotifier.value = malappuramplacesList;
      malappuramListNotifier.notifyListeners();
      palakkaduListNotifier.value = palakkaduplacesList;
      palakkaduListNotifier.notifyListeners();
      pathanamthittaListNotifier.value = palakkaduplacesList;
      pathanamthittaListNotifier.notifyListeners();
      trissurListNotifier.value = thrissurplacesList;
      trissurListNotifier.notifyListeners();
      trivanramListNotifier.value = trivandramplacesList;
      trivanramListNotifier.notifyListeners();
      wayanadListNotifier.value = wayanadplacesList;
      wayanadListNotifier.notifyListeners();
      commonDistrictListNotifier.value = commonplacesList;
      commonDistrictListNotifier.notifyListeners();
      hillStationCatrgoryListNotifier.value = hillStationsplacesList;
      hillStationCatrgoryListNotifier.notifyListeners();
      momumentsCategoryListNotifier.value = monumentsplacesList;
      momumentsCategoryListNotifier.notifyListeners();
      waterfallsCategoryListNotifier.value = waterfallsplacesList;
      waterfallsCategoryListNotifier.notifyListeners();
      forestsCategoryNotifier.value = forestsplacesList;
      forestsCategoryNotifier.notifyListeners();
      beachCategoryNotifier.value = beachesplacesList;
      beachCategoryNotifier.notifyListeners();
      lakeCategoryNotifier.value = lakeplacesList;
      lakeCategoryNotifier.notifyListeners();
    } catch (error) {
      print('Error fetching places: $error');
      // Handle error
    }
  }

  // List<ModelPlace> getPlaceList() {
  //         return List.generate(
  //           placeList.length,
  //           (index) => ModelPlace(
  //             district: districtFromString(
  //               placeList[index]['selectedDistrict'],
  //             ),
  //             category: categoryFromString(
  //               placeList[index]['selectedCategory'],
  //             ),
  //             placeName: placeList[index]['PlaceName'],
  //             subPlaceName: placeList[index]['SubName'],
  //             price: placeList[index]['price'],
  //             durations: placeList[index]['Duration'],
  //             description: placeList[index]['Description'],
  //             images: (placeList[index]['images'] as List<dynamic>)
  //                 .map((dynamic item) => item.toString())
  //                 .toList(),
  //           ),
  //         );
  //       }

  // Future<void> reFreshUI() async {
  //         final allPlaces = await getPlaceList();
  //         placeListNotifier.value.clear();
  //         hillStationCatrgoryListNotifier.value.clear();
  //         desertsCategoryNotifier.value.clear();
  //         forestsCategoryNotifier.value.clear();
  //         momumentsCategoryListNotifier.value.clear();
  //         waterfallsCategoryListNotifier.value.clear();
  //         beachCategoryNotifier.value.clear();
  //         await Future.forEach(
  //           allPlaces,
  //           (ModelPlace place) {
  //             placeListNotifier.value.add(place);
  //             if (place.category != null) {
  //               if (place.category == PlaceCategory.hillStations) {
  //                 hillStationCatrgoryListNotifier.value.add(place);
  //               } else if (place.category == PlaceCategory.lake) {
  //                 desertsCategoryNotifier.value.add(place);
  //               } else if (place.category == PlaceCategory.forests) {
  //                 forestsCategoryNotifier.value.add(place);
  //               } else if (place.category == PlaceCategory.monuments) {
  //                 momumentsCategoryListNotifier.value.add(place);
  //               } else if (place.category == PlaceCategory.waterfalls) {
  //                 waterfallsCategoryListNotifier.value.add(place);
  //               } else if (place.category == PlaceCategory.beaches) {
  //                 beachCategoryNotifier.value.add(place);
  //               }
  //             }
  //           },
  //         );
  //         placeListNotifier.notifyListeners();
  //         hillStationCatrgoryListNotifier.notifyListeners();
  //         desertsCategoryNotifier.notifyListeners();
  //         forestsCategoryNotifier.notifyListeners();
  //         momumentsCategoryListNotifier.notifyListeners();
  //         waterfallsCategoryListNotifier.notifyListeners();
  //         beachCategoryNotifier.notifyListeners();

  //         alappuzhaListNotifier.value.clear();
  //         ernakulamListNotifier.value.clear();
  //         idukkiListNotifier.value.clear();
  //         kannurListNotifier.value.clear();
  //         kasargodeListNotifier.value.clear();
  //         kollamListNotifier.value.clear();
  //         kozhikodeListNotifier.value.clear();
  //         malappuramListNotifier.value.clear();
  //         palakkaduListNotifier.value.clear();
  //         pathanamthittaListNotifier.value.clear();
  //         trissurListNotifier.value.clear();
  //         trivanramListNotifier.value.clear();
  //         wayanadListNotifier.value.clear();
  //         commonDistrictListNotifier.value.clear();
  //         await Future.forEach(
  //           allPlaces,
  //           (ModelPlace place) {
  //             if (place.district == District.Alappuzha) {
  //               alappuzhaListNotifier.value.add(place);
  //             } else if (place.district == District.Ernakulam) {
  //               ernakulamListNotifier.value.add(place);
  //             } else if (place.district == District.Idukki) {
  //               idukkiListNotifier.value.add(place);
  //             } else if (place.district == District.Kannur) {
  //               kannurListNotifier.value.add(place);
  //             } else if (place.district == District.Kasargode) {
  //               kasargodeListNotifier.value.add(place);
  //             } else if (place.district == District.Kollam) {
  //               kollamListNotifier.value.add(place);
  //             } else if (place.district == District.Kottayam) {
  //               kottayamListNotifier.value.add(place);
  //             } else if (place.district == District.Kozhikode) {
  //               kozhikodeListNotifier.value.add(place);
  //             } else if (place.district == District.Malappuram) {
  //               malappuramListNotifier.value.add(place);
  //             } else if (place.district == District.Palakkadu) {
  //               palakkaduListNotifier.value.add(place);
  //             } else if (place.district == District.Pathanamthitta) {
  //               pathanamthittaListNotifier.value.add(place);
  //             } else if (place.district == District.Thrissur) {
  //               trissurListNotifier.value.add(place);
  //             } else if (place.district == District.Trivandram) {
  //               trivanramListNotifier.value.add(place);
  //             } else if (place.district == District.Wayanad) {
  //               wayanadListNotifier.value.add(place);
  //             } else {
  //               commonDistrictListNotifier.value.add(place);
  //             }
  //           },
  //         );
  //         alappuzhaListNotifier.notifyListeners();
  //         ernakulamListNotifier.notifyListeners();
  //         idukkiListNotifier.notifyListeners();
  //         kannurListNotifier.notifyListeners();
  //         kasargodeListNotifier.notifyListeners();
  //         kollamListNotifier.notifyListeners();
  //         kottayamListNotifier.notifyListeners();
  //         kozhikodeListNotifier.notifyListeners();
  //         malappuramListNotifier.notifyListeners();
  //         palakkaduListNotifier.notifyListeners();
  //         pathanamthittaListNotifier.notifyListeners();
  //         trissurListNotifier.notifyListeners();
  //         wayanadListNotifier.notifyListeners();
  //         trivanramListNotifier.notifyListeners();
  //         commonDistrictListNotifier.notifyListeners();
  //       }

  // Update the ValueNotifier with the obtained list
  // _placeListNotifier.value = getPlaceList();
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
