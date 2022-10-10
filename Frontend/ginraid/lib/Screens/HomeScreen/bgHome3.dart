import 'package:flutter/material.dart';



class bgHome3{
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
                "assets/image/Home3.png",

              ),
            ),
            
          ],
        ),
        // ignore: dead_code
      ),
    );
  }

  bgHome3();
}
