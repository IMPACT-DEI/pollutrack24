import 'package:flutter/material.dart';
import 'package:pollutrack24/screens/personal_info.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12.0, right: 12.0, top: 60, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text("Info about you and your preferences",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Account",
              style: TextStyle(fontSize: 16),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Text(
                    "Personal Info",
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PersonalInfo()));
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Pollutrack aims to improve the consciousness of the user to the air pollutants issue. The user can track the amount of pollutants they has been exposed to during the day and learn useful information about them.",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.4)),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text("version 2.0.0"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
