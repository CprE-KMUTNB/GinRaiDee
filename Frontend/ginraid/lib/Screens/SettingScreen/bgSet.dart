// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class bgSet {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/setting.png'), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(47.0),
          bottomLeft: Radius.circular(47.0),
        ),
        // ignore: dead_code
      ),
    );
  }

  bgSet();
}
