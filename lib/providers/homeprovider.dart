import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pollutrack24/models/heart_rate.dart';
import 'package:pollutrack24/models/pm25.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pollutrack24/services/impact.dart';
import 'package:pollutrack24/services/purpleair.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  List<HR> heartRates = [];
  List<PM25> pm25 = [];
  double exposure = 0;
  String nick = 'User';
  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  // data generators from external services
  final Impact impact = Impact();
  final PurpleAir purpleAir = PurpleAir();

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  HomeProvider() {
    getDataOfDay(showDate);
  }

  // method to get the data of the chosen day
  void getDataOfDay(DateTime showDate) async {
    showDate = DateUtils.dateOnly(showDate);
    this.showDate = showDate;
    _loading(); // method to give a loading ui feedback to the user
    heartRates = await impact.getDataFromDay(showDate);
    var pm25Map = await purpleAir.getHistoryData(showDate);
    pm25 = (pm25Map['data'])
        .map<PM25>((e) => PM25(
            timestamp:
                DateTime.fromMillisecondsSinceEpoch((e[0] * 1000).toInt()),
            value: e[1]))
        .toList();
    pm25.sort(
      (a, b) => a.timestamp.compareTo(b.timestamp),
    );
    exposure = Random().nextDouble() * 100;
    print('Got data for $showDate: ${heartRates.length}, ${pm25.length}');
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }

  void _loading() {
    heartRates = [];
    pm25 = [];
    exposure = 0;
    notifyListeners();
  }
}
