import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pollutrack24/utils/custom_plot.dart';
import 'package:pollutrack24/providers/homeprovider.dart';
import 'package:provider/provider.dart';

class Exposure extends StatelessWidget {
  const Exposure({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        builder: (context, child) => Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12.0, top: 10, bottom: 20),
          child: Consumer<HomeProvider>(builder: (context, provider, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${provider.nick}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Daily Personal Exposure',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF326f5e),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              provider.getDataOfDay(provider.showDate
                                  .subtract(const Duration(days: 1)));
                            },
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFFFFF),
                              ),
                              child: const Icon(
                                Icons.navigate_before,
                              ),
                            ),
                          ),
                        ),
                        //Text(DateFormat('EEE, d MMM').format(provider.showDate)),
                        Text(
                          DateFormat('EEE, d MMM').format(provider.showDate),
                          style: const TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              provider.getDataOfDay(
                                  provider.showDate.add(const Duration(days: 1)));
                            },
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFFFFF),
                              ),
                              child: const Icon(
                                Icons.navigate_next,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
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
                Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFedf1f1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 10, bottom: 4),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (provider.exposure.toInt()).toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          provider.exposure / 100 < 0.33
                              ? "Low"
                              : provider.exposure / 100 > 0.33 &&
                                      provider.exposure / 100 < 0.66
                                  ? "Medium"
                                  : "High",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black45),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          height: 15,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: LinearProgressIndicator(
                              value: provider.exposure / 100,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        )
                      ],
                    ),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFedf1f1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        if (provider.heartRates.isEmpty) {
                          return const CircularProgressIndicator.adaptive();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomPlot(
                            inhalationRates: provider.inhalationRate,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Learn Something More",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 250,
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () {
                          // handle button press
                        },
                        child: SizedBox(
                            width: 300,
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 300,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/tyler-nix-VZEj0iepzKA-unsplash.jpg'),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "What's Exposure?",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          // handle button press
                        },
                        child: SizedBox(
                            width: 300,
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 300,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/mike-marrah-8687b4ITjhA-unsplash.jpg'),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "What's Air Pollution?",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      )),
    );
  }
}
