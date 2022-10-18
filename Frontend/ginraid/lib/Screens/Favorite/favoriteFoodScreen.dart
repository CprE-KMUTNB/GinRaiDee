// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Favorite/bgFav3.dart';
import 'package:ginraid/Screens/Favorite/favfood.dart';




class favFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const favFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _favFoodScreenState();
  }
}

class _favFoodScreenState extends State<favFoodScreen> {
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
          bgfav3().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(
              top: 75,
            ),
            child: Column(
              children: [
                //row 1
                Row(
                  children: [
                    //กำลังติดตาม text
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'อาหารที่ชอบ ',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "IBMPlexSansThaiReg",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //จำนวนที่กดถูกใจ
                    Container(
                      child: Text(
                        ' 4',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "IBMPlexSansThaiReg",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ],
                ),

                //searchFood
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15, left: 20, right: 20),
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

                //กล่องใหญ่
                Container(
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(47),
                      topLeft: Radius.circular(47),
                    ),
                  ),
                  height: screenHeight * 0.7,
                  width: screenWidth,
                  child: 
                  //กล่องที่ใส่เมนูที่ถูกใจไว้ กล่องใหญ่
                  Container(
                    margin: EdgeInsets.only(top: 15 ,left: 10,right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          //post ที่ถูกใจ
                          favfood(),
                          favfood(),
                          favfood(),
                          favfood(),
                          favfood(),
                          favfood(),
                        ],
                      ),
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
