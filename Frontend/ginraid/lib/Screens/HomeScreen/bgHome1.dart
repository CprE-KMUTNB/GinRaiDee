import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';

class bgHome1 {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/Home1.png'),
          // return SafeArea(
          //   child: Container(

          //     width: screenWidth,
          //     height: 150,
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/image/loginbacktrans.png'),
          //     ),
          //   ),
          // )
          // Positioned(
          //   top: 0,
          //   child:
          //   Image.asset(
          //     "assets/image/Home1.png",height: 150,

          //   ),
          // ),

          // ],
        ),
        // ignore: dead_code
      ),
    );
  }

  bgHome1();
}
