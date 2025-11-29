// ignore_for_file: unused_import

import 'package:aqua_mind/util/daily_calculate.dart';
import 'package:aqua_mind/view/home_page.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int height;
  final int weight;
  final double dailyWater;
  const Result(
      {super.key,
      required this.height,
      required this.weight,
      required this.dailyWater});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    double liter = dailyWater / 1000;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Günlük ${liter.toStringAsFixed(1)} litre su içmelisin',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          RawMaterialButton(
            elevation: 10,
            fillColor: Colors.lightBlue,
            constraints: BoxConstraints.tightFor(
              width: width * 0.15,
              height: width * 0.15,
            ),
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: width * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}
