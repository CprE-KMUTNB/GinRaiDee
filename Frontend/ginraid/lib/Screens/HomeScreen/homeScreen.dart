// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/services.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';

class homeScreen extends StatefulWidget {
  static const routeName = '/';

  const homeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homeScreenState();
  }
}

class _homeScreenState extends State<homeScreen> {
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
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),

     
      body: Stack(
        children: [
          bgHome1().buildBackground(screenWidth, screenHeight),

          //search
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 110, left: 25, right: 25),
            height: 40,
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 179, 190, 190),
                ),
                hintText: 'Search Foods',
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Itim",
                  color: Color.fromARGB(255, 179, 190, 190),
                ),
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Itim",
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),

          //กล่องใหญ่ไว้ใส่ card
          Container(
            margin: EdgeInsets.only(top: 180, left: 15, right: 15),
            height: 600,
            width: 500,
            // color: Colors.blueAccent,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                
                //1post
                post(),
                post(),
                post(),
              ]

                  //post

                  ),
            ),
          ),
        ],
      ),
    );
  }


}
