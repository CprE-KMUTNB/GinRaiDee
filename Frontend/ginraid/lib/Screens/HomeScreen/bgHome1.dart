import 'package:flutter/material.dart';

class bgHome1 {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 165,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/Home1.png'),
          fit: BoxFit.fill
         
        ),
        // ignore: dead_code
      ),
    );
  }

  bgHome1();
}
