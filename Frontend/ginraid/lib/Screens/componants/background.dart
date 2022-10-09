import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';


class Mybackground {
  SafeArea buildBackground(double screenWidth, double screenHeight) {
    return SafeArea(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/image/loginbacktrans.png'),
            //     ),
            //   ),
            // )
            Positioned(
              top: 0,
              child:
              Image.asset(
                "assets/image/loginbacktrans.png",

              ),
            ),
            
          ],
        ),
        // ignore: dead_code
      ),
    );
  }

  Mybackground();
}
