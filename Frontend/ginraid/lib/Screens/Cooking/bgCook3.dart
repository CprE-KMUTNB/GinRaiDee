// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class bgCook3 {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/cook3.png'), 
            fit: BoxFit.fill),
        
        // ignore: dead_code
      ),
    );
  }

  bgCook3();
}
