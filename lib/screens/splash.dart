import 'package:flutter/material.dart';
import 'package:pollutrack24/screens/home.dart';
import 'package:pollutrack24/screens/login.dart';
import 'package:pollutrack24/screens/overview_daily_trend.dart';
import 'package:pollutrack24/services/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
  } //_toHomePage

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => const Login())));
  } //_toLoginPage

  void _checkLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getString('overview') == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const OverviewDailyTrendPage()));
    } else {
      final result = await Impact().refreshTokens();
      if (result == 200) {
        _toHomePage(context);
      } else {
        _toLoginPage(context);
      }
    }
  } //_checkLogin

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () => _checkLogin(context));
    return Scaffold(
        body: Center(
            child: Image.asset(
      'assets/logo.png',
      scale: 4,
    )));
  }
}
