// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pollutrack24/screens/home.dart';
import 'package:pollutrack24/screens/login.dart';
import 'package:pollutrack24/services/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OverviewLearnMorePage extends StatelessWidget {
  const OverviewLearnMorePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Learn More',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 400,
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/learnmore.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "Get knowledge about air pollutiuon and exposure to it",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                  )),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Back')),
                  ElevatedButton(
                    onPressed: () async {
                      final sp = await SharedPreferences.getInstance();
                      await sp.setString('overview', 'done');
                      final result = await Impact().refreshTokens();
                      if (result == 200) {
                        _toHomePage(context);
                      } else {
                        _toLoginPage(context);
                      }
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
  } //_toHomePage

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const Login())));
  } //_toLoginPage
}
