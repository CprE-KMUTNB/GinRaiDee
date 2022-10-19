import 'package:flutter/material.dart';


class bgCook4 {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/cook2.png'),
          fit: BoxFit.fill
         
        ),
        
        // ignore: dead_code
      ),
    );
  }

  bgCook4();
}
