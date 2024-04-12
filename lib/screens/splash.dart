import 'package:flutter/material.dart';
import 'package:pollutrack24/screens/home.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> LoginPage
  void _toHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const Home())));
  } //_toLoginPage

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => _toHomePage(context));
    return Scaffold(
        body: Center(
            child: Image.asset(
      'assets/logo.png',
      scale: 4,
    )));
  }
}
