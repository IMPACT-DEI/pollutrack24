import 'dart:math';

class PM25 {
  // this class models the single PM2.5 data point
  final DateTime timestamp;
  final double value;

  PM25({required this.timestamp, required this.value});
}

class PurpleAirGen {
  final Random _random = Random();
  List<PM25> fetchPM() {
    return List.generate(
        100,
        (index) => PM25(
            timestamp: DateTime.now().subtract(Duration(minutes: 10 * index)),
            value: _random.nextDouble() * 150));
  }
}
