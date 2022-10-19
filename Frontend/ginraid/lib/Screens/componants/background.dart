import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';

class Mybackground {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/loginbacktrans.png'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(47.0),
          bottomLeft: Radius.circular(47.0),
        ),
        // ignore: dead_code
      ),
      // ignore: dead_code
    );
  }

  Mybackground();
}
