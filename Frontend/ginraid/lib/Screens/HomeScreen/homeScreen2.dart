// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome2.dart';

import 'package:ginraid/Screens/HomeScreen/homeScreen3.dart';

class homeScreen2 extends StatefulWidget {
  static const routeName = '/';
  int id;
  int owner;
  String ownerName;
  String ownerPic;
  bool isFollowing;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isFavorites;
  int favoritesCount;
  DateTime created;
  homeScreen2({
    required this.id,
    required this.owner,
    required this.ownerName,
    required this.ownerPic,
    required this.isFollowing,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isFavorites,
    required this.favoritesCount,
    required this.created,
  });

  @override
  State<StatefulWidget> createState() {
    return _homeScreen2State(
        id: id,
        owner: owner,
        ownerName: ownerName,
        ownerPic: ownerPic,
        isFollowing: isFollowing,
        foodname: foodname,
        foodpic: foodpic,
        ingredient: ingredient,
        recipes: recipes,
        isFavorites: isFavorites,
        favoritesCount: favoritesCount,
        created: created);
  }
}

class _homeScreen2State extends State<homeScreen2> {
  int id;
  int owner;
  String ownerName;
  String ownerPic;
  bool isFollowing;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isFavorites;
  int favoritesCount;
  DateTime created;
  _homeScreen2State({
    required this.id,
    required this.owner,
    required this.ownerName,
    required this.ownerPic,
    required this.isFollowing,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isFavorites,
    required this.favoritesCount,
    required this.created,
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
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              bgHome2().buildBackground(screenWidth, screenHeight),
              //กล่องใหญ่ๆ
              Container(
                margin: const EdgeInsets.only(
                  top: 210.0,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(60),
                ),
                height: 600,
                width: screenWidth,
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // color: Colors.amberAccent,
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 80, left: 20),
                        child: Text(
                          foodname,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: "Sriracha",
                            color: Colors.white,
                          ),
                        ),
                      ),

                      //ไปหน้า user
                      Container(
                        // color: Colors.grey,
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          top: 80,
                        ),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => homeScreen3(
                                        owner: owner,
                                        ownerName: ownerName,
                                        ownerPic: ownerPic,
                                        isFollowing: isFollowing,
                                      )),
                            ),
                          },
                          child: Row(
                            children: [
                              Container(
                                // margin: EdgeInsets.only(top: 35),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 226, 226, 226),
                                  image: DecorationImage(
                                      image: NetworkImage(ownerPic),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(360)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  ownerName,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Itim",
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //รูป
                  Container(
                    // color: Colors.amber,
                    height: 180,
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(foodpic), fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),

                 

                  //วัตถุดิบ
                  Container(
                    // color: Colors.indigo,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        //วัตถุดิบ หัวข้อ
                        Container(
                          alignment: Alignment.topLeft,
                          // color: Colors.red,
                          child: Text(
                            'วัตถุดิบ',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "IBMPlexSansThai",
                                color: Color.fromARGB(255, 166, 198, 6),
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        //วัตถุดิบ รับค่า
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            ingredient,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "IBMPlexSansThai",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //วิธีทำ
                  Container(
                    // color: Colors.indigo,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        //วิธีทำ หัวข้อ
                        Container(
                          alignment: Alignment.topLeft,
                          // color: Colors.red,
                          child: Text(
                            'วิธีทำ',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "IBMPlexSansThai",
                                color: Color.fromARGB(255, 166, 198, 6),
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        //วิธีทำ รับค่า
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            recipes,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "IBMPlexSansThai",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));


  }
}
