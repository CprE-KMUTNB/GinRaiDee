// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class bgNoti {
  buildBackground(double screenWidth, double screenHeight) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/noti.png'), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(47.0),
          bottomLeft: Radius.circular(47.0),
        ),
        // ignore: dead_code
      ),
    );
  }

  bgNoti();
}
