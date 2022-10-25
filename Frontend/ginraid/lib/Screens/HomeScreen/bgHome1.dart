import 'package:flutter/material.dart';

class bgHome1 {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/Home1.png'),
         
        ),
        // ignore: dead_code
      ),
    );
  }

  bgHome1();
}
