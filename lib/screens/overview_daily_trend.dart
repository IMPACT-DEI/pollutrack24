import 'package:flutter/material.dart';
import 'package:pollutrack24/screens/overview_cum_exposure.dart';

class OverviewDailyTrendPage extends StatelessWidget {
  const OverviewDailyTrendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Daily Trend',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
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
                    image: AssetImage('assets/plot.png'),
                  ),
                ),
              ),
              const Text("See how much you’ve been exposed throughout the day",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                  )),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const OverviewCumExposurePage()));
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF384242))),
                    child: const Text('Next'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
