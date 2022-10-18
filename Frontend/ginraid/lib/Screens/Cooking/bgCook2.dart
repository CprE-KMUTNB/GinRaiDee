// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class bgCook2 {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/cook2.png'), 
            fit: BoxFit.fill),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(47.0),
          bottomLeft: Radius.circular(47.0),
        ),
        // ignore: dead_code
      ),
    );
  }

  bgCook2();
}
