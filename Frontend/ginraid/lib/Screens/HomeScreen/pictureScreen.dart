// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/SettingScreen/bgSet.dart';
import 'package:ginraid/Screens/SettingScreen/settingrequest.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class PictureScreen extends StatefulWidget {
  static const routeName = '/';

  String foodpic;

  PictureScreen({
    required this.foodpic,
  });

  @override
  State<StatefulWidget> createState() {
    return _PictureScreenState(
      foodpic: foodpic,
    );
  }
}

class _PictureScreenState extends State<PictureScreen> {
  String foodpic;

  _PictureScreenState({
    required this.foodpic,
  });
  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => {},
            child: Container(
              alignment: Alignment.center,
              // color: Colors.amber,
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(foodpic),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
