import 'dart:math';

class HR {
  // this class models the single heart rate data point
  final DateTime timestamp;
  final int value;

  HR({required this.timestamp, required this.value});
}

class FitbitGen {
  final Random _random = Random();

  List<HR> fetchHR() {
    return List.generate(
        100,
        (index) => HR(
            timestamp: DateTime.now().subtract(Duration(minutes: 10 * index)),
            value: _random.nextInt(180)));
  }
}
