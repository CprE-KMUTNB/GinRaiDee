// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/services.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome2.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome3.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';
import 'package:ginraid/Screens/HomeScreen/postInHomeScreen3.dart';

import 'homeScreen2.dart';

class homeScreen3 extends StatefulWidget {
  static const routeName = '/';

  const homeScreen3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homeScreen3State();
  }
}

class _homeScreen3State extends State<homeScreen3> {
  bool isFollowedByMe = true;
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
      ),
      body: Stack(
        children: [
          bgHome3().buildBackground(screenWidth, screenHeight),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 80, left: 10, right: 10),
            child: Column(
              children: [
                //แถวแรก
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Align(
                    //   alignment: Alignment.center,
                    // ),
                    //name user icon
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.account_circle,
                            size: 45,
                          ),
                        ),

                        //name user
                        Container(
                          child: Text(
                            '  User 1',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Itim",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //follow buttom
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  isFollowedByMe = !isFollowedByMe;
                                  //ฟอลอยู่           ไม่ฟอล อัลฟอล
                                },
                              );
                            },
                            child: AnimatedContainer(
                              height: 35,
                              width: 110,
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                
                              ),
                              child: Center(
                                child: Text(
                                  isFollowedByMe ? 'Following' : 'Follow',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "IBMPlexSansThaiReg",
                                    color: isFollowedByMe
                                        ? Color.fromARGB(255, 166, 198, 6)
                                        : Color.fromARGB(255, 251, 0, 0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //report buttom
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          child: Icon(
                            Icons.report,
                            size: 30,
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //แถวที่2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //text ผู้ติดตาม
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'ผู้ติดตาม ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "IBMPlexSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //จำนวนผู้ติดตาม
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        '100 ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "IBMPlexSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //หน่วย
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'คน',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "IBMPlexSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //text เมนูอาหาร
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 10),
                      child: Text(
                        'เมนูอาหาร ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "IBMPlexSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //จำนวน เมนูอาหาร
                    Container(
                      margin: EdgeInsets.only(
                        top: 30,
                      ),
                      child: Text(
                        '10 ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "IBMPlexSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //หน่วย เมนูอาหาร
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'รายการ ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "IBMPlexSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 25,
                ),

                Container(
                  // color: Colors.amber,
                  // margin: EdgeInsets.only(left: 15, right: 15),
                  height: 560,
                  width: screenWidth,
                  // color: Colors.blueAccent,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      //1post
                      Userpost(context),
                      Userpost(context),
                      Userpost(context),
                    ]

                        //post

                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
