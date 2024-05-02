import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pollutrack24/screens/exposure.dart';
import 'package:pollutrack24/screens/login.dart';
import 'package:pollutrack24/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selIdx = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selIdx = index;
    });
  }

  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.account),
      label: 'Profile',
    ),
  ];

  Widget _selectPage({
    required int index,
  }) {
    switch (index) {
      case 0:
        return Exposure();
      case 1:
        return Profile();
      default:
        return Exposure();
    }
  }

  _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();

    // opt 1: remove specific keys
    // await sp.remove("age");
    // await sp.remove("gender");
    // await sp.remove("username");
    // await sp.remove("password");

    // opt 2: clear whole shared prefs
    await sp.clear();

    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _selectPage(index: _selIdx),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFf5f7f7),
          items: navBarItems,
          currentIndex: _selIdx,
          onTap: _onItemTapped,
        ));
  }
}
