// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/%E0%B9%8C%E0%B9%8CNotification/bgNoti.dart';
import 'package:ginraid/Screens/%E0%B9%8C%E0%B9%8CNotification/notiCard.dart';
import 'package:ginraid/Screens/Favorite/bgFav3.dart';
import 'package:ginraid/Screens/Favorite/favfood.dart';

class NotiScreen extends StatefulWidget {
  // static const routeName = 'NotiScreen';

  const NotiScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotiScreenState();
  }
}

class _NotiScreenState extends State<NotiScreen> {
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
          'Notifications',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          bgNoti().buildBackground(screenWidth, screenHeight),
          Container(
            height: screenHeight * 0.82,
            width: screenWidth,
            margin: EdgeInsets.only(top: 90),
            padding: EdgeInsets.only(top: 10,right: 10,left: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(47),
                topLeft: Radius.circular(47),
              ),
            ),
            child: Column(
              children: [
                Container(
                  // color: Colors.amber,
                  // margin: EdgeInsets.only(left: 15, right: 15),
                  // height: 560,
                  width: screenWidth,
                  height: screenHeight * 0.8,
                  // color: Colors.blueAccent,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      //1post
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                      noti(context),
                    ]

                        //post

                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
