import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Exposure extends StatefulWidget {
  Exposure({super.key});

  @override
  State<Exposure> createState() => _ExposureState();
}

class _ExposureState extends State<Exposure> {
  double exposure = 2.5;

  DateTime day = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, top: 10, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello, User",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Daily Personal Exposure',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    day = day.subtract(const Duration(days: 1));
                  });
                },
                child: const Icon(
                  Icons.navigate_before,
                ),
              ),
            ),
            //Text(DateFormat('EEE, d MMM').format(provider.showDate)),
            Text(
              DateFormat('EEE, d MMM').format(day),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    day = day.add(const Duration(days: 1));
                  });
                },
                child: const Icon(
                  Icons.navigate_next,
                ),
              ),
            ),
          ]),
          const Text(
            "Cumulative Exposure",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
              "Total count of all the pollution you've breathed in the day",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              )),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10, bottom: 4),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (exposure.toInt()).toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  exposure / 100 < 0.33
                      ? "Low"
                      : exposure / 100 > 0.33 && exposure / 100 < 0.66
                          ? "Medium"
                          : "High",
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  height: 15,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: exposure / 100,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Daily Trend",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("See how much you’ve been exposed throughout the day",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              )),
          const AspectRatio(
            aspectRatio: 16 / 9,
            child: Placeholder(
              child: Align(
                  alignment: Alignment.bottomCenter, child: Text('Daily plot')),
            ),
          ),
        ],
      ),
    ));
  }
}
