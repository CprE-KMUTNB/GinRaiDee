// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/EditFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/addFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/myFood.dart';

class myFoodScreen extends StatefulWidget {
  static const routeName = 'myfoodScreen';

  const myFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _myFoodScreenState();
  }
}

class _myFoodScreenState extends State<myFoodScreen> {
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
          'Cooking',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),

      //ปุ่มเพิ่มเมนู
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addFoodScreen()),
          ),
        },
        child: ImageIcon(
          AssetImage('assets/icons/addFood.png'),
          size: 50,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: Color.fromARGB(255, 226, 137, 22),
      ),

      body: Stack(
        children: [
          bgCook1().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                //แถว1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //ชื่อหัวข้อ รายการอาหารของฉัน
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'รายการอาหารของฉัน',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "NotoSansThai",
                              color: Colors.white,
                            ),
                          ),
                        ),

                        //รับค่า จำนวนเมนูอาหารที่อัปโหลดของเจ้าของ
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            '4',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "NotoSansThai",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    

                    // GestureDetector(
                    //   onTap: () => {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const addFoodScreen()),
                    //     ),
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.only(right: 15),
                    //     width: 60,
                    //     height: 60,
                    //     decoration: ShapeDecoration(
                    //         color: Color.fromARGB(255, 226, 137, 22),
                    //         shape: CircleBorder()),
                    //     child: ImageIcon(
                    //       AssetImage('assets/icons/addFood.png'),
                    //       size: 50,
                    //       color: Color.fromARGB(255, 255, 255, 255),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                //searchFood แถว 2
                Container(
                  // alignment: Alignment.center,
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
                  margin: EdgeInsets.only(top: 35),
                  height: screenHeight * 0.7,
                  width: screenWidth,
                  child:
                      //กล่องที่ใส่เมนู กล่องใหญ่
                      Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          //เมนูของฉัน
                          myFood(context),
                          myFood(context),
                          myFood(context),
                          myFood(context),
                          myFood(context),
                        ],
                      ),
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
