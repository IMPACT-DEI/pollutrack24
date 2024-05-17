// This file contains the formulas needed to compute the personal exposure to air pollution (a.k.a as inhalation rate).
// According to Borghi et al. (Borghi, F.; Spinazzè, A.; Mandaglio, S.; Fanti, G.; Campagnolo, D.; Rovelli, S.; Keller, M.; Cattaneo, A.; Cavallo, D.M. Estimation of the Inhaled Dose of Pollutants in Different Micro-Environments: A Systematic Review of the Literature. Toxics 2021, 9, 140. https://doi.org/10.3390/toxics9060140)
// the inhalation rate is the product of the measured pollutant and ventilation rate** over a certain time period t.
// ** How do we compute ventilation rate though?
// Measuring it in daily life is challenging, as it requires to wear a mask all the time. To overcome this, some ventialtion rate estimators, starting from heart rate measurements, were proposed in the literature.
// According to Zuurbier et al. (Cruz R, Alves DL, Rumenig E, Gonçalves R, Degaki E, Pasqua L, Koch S, Lima-Silva AE, S Koehle M, Bertuzzi R. Estimation of minute ventilation by heart rate for field exercise studies. Sci Rep. 2020 Jan 29;10(1):1423. doi: 10.1038/s41598-020-58253-7. PMID: 31996732; PMCID: PMC6989498.)
// the ventilation rate can be estimated as:
// MENs -> e^[1.03 + (0.021 * HR)]
// WOMENs -> e^[0.57 + (0.023 * HR)]

import 'package:pollutrack24/models/heart_rate.dart';
import 'package:pollutrack24/models/inhalation_rate.dart';
import 'package:pollutrack24/models/pm25.dart';
import 'dart:math' as math;

import 'package:pollutrack24/models/ventilation_rate.dart';

class Algorithmms {
  int gender = 1;
  Algorithmms(this.gender);

  List<VentilationRate> getVentilationRate(List<HR> heartrates) {
    List<VentilationRate> vent = [];
    for (HR heartrate in heartrates) {
      if (heartrate.value != 0) {
        if (gender == 1) {
          // MENs
          double val =
              math.pow(math.e, 1.03 + (0.021 * heartrate.value)) as double;
          vent.add(VentilationRate(
              timestamp: heartrate.timestamp,
              value: (val * 100).roundToDouble() / 100));
        } else {
          // WOMENs
          double val =
              math.pow(math.e, 0.57 + (0.023 * heartrate.value)) as double;
          vent.add(VentilationRate(
              timestamp: heartrate.timestamp,
              value: (val * 100).roundToDouble() / 100));
        }
      } else {
        vent.add(VentilationRate(timestamp: heartrate.timestamp, value: 0));
      }
    }
    return vent;
  }

  List<InhalationRate> getInhalationRate(
      List<VentilationRate> minuteVentilation, List<PM25> pms) {
    List<InhalationRate> inh = [];
    for (PM25 pm in pms) {
      List<VentilationRate> tmp = minuteVentilation
          .where((element) =>
              element.timestamp.difference(pm.timestamp) >
                  const Duration(minutes: -10) &&
              element.timestamp.difference(pm.timestamp) <= Duration.zero)
          .toList();

      if (tmp.isNotEmpty) {
        double tmpMean = tmp
                .map((e) => e.value)
                .reduce((value, element) => value + element) /
            tmp.length;

        inh.add(InhalationRate(
            timestamp: pm.timestamp, value: tmpMean * pm.value * 10 / 1000));
      }
    }
    return inh;
  }
}
