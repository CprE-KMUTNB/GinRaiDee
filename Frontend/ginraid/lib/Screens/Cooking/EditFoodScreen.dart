// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/addFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook3.dart';
import 'package:ginraid/Screens/Cooking/myFood.dart';

class EditFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const EditFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditFoodScreenState();
  }
}

class _EditFoodScreenState extends State<EditFoodScreen> {
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
          bgCook3().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                //แถว1
                //ชื่อหัวข้อ แก้ไขเมนูอาหาร
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'แก้ไขเมนูอาหาร',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "NotoSansThai",
                      color: Colors.white,
                    ),
                  ),
                ),

                //กล่องใหญ่
                Container(
                  margin: EdgeInsets.only(top: 20),                  
                  width: screenWidth,
                  height: screenHeight*0.77,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(47),
                      topLeft: Radius.circular(47),
                    ),
                  ),
                  child: Column(
                    children: [

                      TextField(                            
                            decoration: InputDecoration(                              
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 179, 190, 190)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              hintText: 'ชื่อเมนู',
                              hintStyle: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 179, 190, 190),
                              ),
                              labelText: 'ผัดกะเพรา',
                              labelStyle: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                    ],
                  ),
                  
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
