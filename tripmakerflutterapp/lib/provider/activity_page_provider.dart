import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/controller/addTrip_model/addTrip_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

class ActivityPageProvider extends ChangeNotifier {
  //to refresh the hive database valueNotifier
  void reFreshListUI() {
    AddtripDB.instance.refreshListUI();
    // notifyListeners();
  }

  //to pick the date

  DateTime _startdateTime = DateTime.now();
  DateTime _enddateTime = DateTime.now();

  DateTime get startDate => _startdateTime;

  DateTime get endDate => _enddateTime;
  void showDatePickerUI(bool isStartDate, BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _startdateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    ).then(
      (value) {
        if (isStartDate) {
          _startdateTime = value!;
          notifyListeners();
        } else {
          _enddateTime = value!;
          notifyListeners();
        }
      },
    );
  }

  //set state
  ModelPlace? place;

  ModelPlace setStateModelPlace(ModelPlace selectedPlace) {
    notifyListeners();
    return place = selectedPlace;
  }
}
