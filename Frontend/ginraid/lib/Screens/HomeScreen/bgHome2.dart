import 'package:flutter/material.dart';


class bgHome2 {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/Home2.png'),
          fit: BoxFit.fill
         
        ),
        
        // ignore: dead_code
      ),
    );
  }

  bgHome2();
}
