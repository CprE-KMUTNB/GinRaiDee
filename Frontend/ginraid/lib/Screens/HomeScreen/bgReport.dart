// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class bgReport {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/report.png'), 
            fit: BoxFit.fill),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(47.0),
          bottomLeft: Radius.circular(47.0),
        ),
        // ignore: dead_code
      ),
    );
  }

  bgReport();
}
