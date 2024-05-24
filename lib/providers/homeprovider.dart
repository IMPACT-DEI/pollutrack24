import 'package:flutter/material.dart';
import 'package:pollutrack24/models/heart_rate.dart';
import 'package:pollutrack24/models/inhalation_rate.dart';
import 'package:pollutrack24/models/pm25.dart';
import 'package:pollutrack24/utils/algorithm.dart';
import 'package:pollutrack24/services/impact.dart';
import 'package:pollutrack24/services/purpleair.dart';
import 'package:shared_preferences/shared_preferences.dart';

// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  List<HR> heartRates = [];
  List<PM25> pm25 = [];
  double exposure = 0;
  List<InhalationRate> inhalationRate = [];

  String nick = 'User';
  // selected day of data to be shown
  DateTime showDate = DateTime.now().subtract(const Duration(days: 1));

  // data generators with external services
  final Impact impact = Impact();
  final PurpleAir purpleAir = PurpleAir();

  // Algorithm class
  final Algorithmms algorithm = Algorithmms(1);

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  HomeProvider() {
    getDataOfDay(showDate);
  }

  // method to get the data of the chosen day
  void getDataOfDay(DateTime showDate) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    nick = sp.getString('name') ?? 'User';
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
    print('Got data for $showDate: ${heartRates.length}, ${pm25.length}');
    inhalationRate = _calculateExposure(heartRates, pm25);
    exposure = inhalationRate.map((e) => e.value).reduce(
              (value, element) => value + element,
            ) /
        300 *
        100;
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }

  // method that implements the state of the art formulas
  List<InhalationRate> _calculateExposure(List<HR> hr, List<PM25> pm25) {
    var vent = algorithm.getVentilationRate(hr);
    return algorithm.getInhalationRate(vent, pm25);
  }

  void _loading() {
    heartRates = [];
    pm25 = [];
    exposure = 0;
    notifyListeners();
  }
}
