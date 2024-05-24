import 'package:flutter/material.dart';

class WhatExposure extends StatelessWidget {
  const WhatExposure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What is Exposure?',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: 'exposure',
              child: Container(
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
                    image:
                        AssetImage('assets/tyler-nix-VZEj0iepzKA-unsplash.jpg'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                  'Accurately measuring individuals’ exposure to poor air quality is challenging due to complex interactions between individuals and the environment. The proposed methodology calculates the inhalation (Ipollutant) by multiplying the PM concentration, ventilation rate (VE), i.e. the volume of inhaled air per minute (L/min), and the exposure duration.'),
            )
          ],
        ),
      ),
    );
  }
}
