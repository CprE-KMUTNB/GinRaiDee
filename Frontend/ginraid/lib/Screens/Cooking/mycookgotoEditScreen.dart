// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/EditFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/bgCook2.dart';
import 'package:ginraid/Screens/Cooking/bgCook4.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome2.dart';

import 'package:ginraid/Screens/HomeScreen/homeScreen3.dart';

//เป็นหน้าที่เอาไว้ไปหน้าแก้ไขเมนูอาหาร จะคล้ายๆหน้า home2 แต่จะมีปุ่มให้ไปสู่หน้าแก้ไข
class mycookScreen extends StatefulWidget {
  static const routeName = '/';

  int id;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isPublic;
  mycookScreen({
    required this.id,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isPublic,
  });

  @override
  State<StatefulWidget> createState() {
    return _mycookScreenState(
        id: id,
        foodname: foodname,
        foodpic: foodpic,
        ingredient: ingredient,
        recipes: recipes,
        isPublic: isPublic);
  }
}

class _mycookScreenState extends State<mycookScreen> {
  int id;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isPublic;
  _mycookScreenState({
    required this.id,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isPublic,
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
      body: Stack(
        children: [
          bgCook4().buildBackground(screenWidth, screenHeight),
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

          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      // color: Colors.amberAccent,
                      alignment: Alignment.topLeft,
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

                    //ไปหน้าแก้ไข
                    Container(
                      // color: Colors.grey,
                      alignment: Alignment.topLeft,
                      margin:
                          EdgeInsets.only(top: 95, left: screenWidth * 0.25),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditFoodScreen(
                                    id: id,
                                    foodname: foodname,
                                    foodpic: foodpic,
                                    ingredient: ingredient,
                                    recipes: recipes,
                                    isPublic: isPublic)),
                          ),
                        },
                        child: Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'แก้ไข',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Itim",
                                color: Colors.white,
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
                        image: NetworkImage(foodpic), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),

                //ประเภท

                // Container(
                //   margin: EdgeInsets.only(top: 10, left: 20),
                //   child: Row(
                //     children: [
                //       //ประเภทหัวข้อ
                //       Container(
                //         child: Text(
                //           'ประเภท : ',
                //           style: TextStyle(
                //               fontSize: 25.0,
                //               fontFamily: "IBMPlexSansThai",
                //               color: Colors.black,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ),

                //       //ประเภท รับค่า
                //       Container(
                //         child: Text(
                //           'ผัด , กับข้าว',
                //           style: TextStyle(
                //             fontSize: 20.0,
                //             fontFamily: "IBMPlexSansThai",
                //             color: Colors.black,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

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
          ),
        ],
      ),
    );

    // );
  }
}
