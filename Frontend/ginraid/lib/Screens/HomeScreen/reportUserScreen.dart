// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook2.dart';
import 'package:ginraid/Screens/Cooking/foodrequest.dart';
import 'package:ginraid/Screens/HomeScreen/bgReport.dart';
import 'package:ginraid/Screens/HomeScreen/homescreenrequest.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reportUserScreen extends StatefulWidget {
  static const routeName = '/';

  int id;
  reportUserScreen({required this.id});

  @override
  State<StatefulWidget> createState() {
    return _reportUserScreenState(id: id);
  }
}

class _reportUserScreenState extends State<reportUserScreen> {
  late double screenWidth, screenHeight;
  int id;
  _reportUserScreenState({required this.id});
  final reporttextcontroller = TextEditingController();
  String error = ''; //////////////////////////////////////////////

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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
          bgReport().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(top: 75, left: 20),
            child: Row(
              //แถว1
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'รายงานผู้ใช้ ',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: "NotoSansThai",
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.report,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          //กล่องใหญ่
          Container(
            height: screenHeight * 0.76,
            margin: const EdgeInsets.only(top: 140),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(47),
                topLeft: Radius.circular(47),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //กรอกreport
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: reporttextcontroller,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.bottom,
                      // controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 179, 190, 190)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        hintText: 'เหตุผลที่รายงานผู้ใช้นี้',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelText: 'เหตุผลที่รายงานผู้ใช้นี้',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 85, 85),
                      ),
                      onPressed: () async {
                        if (reporttextcontroller.text.isNotEmpty) {
                          var response = await Report()
                              .post(reporttextcontroller.text, id);
                          if (response.statusCode == 201) {
                            print('reportsuccess');
                            //redirect to "เราได้รับเรื่องแล้ว"
                          } else {
                            setState(() {
                              error = 'Server down';
                            });
                            print(error);
                          }
                        } else {
                          setState(() {
                            error = 'Field could not be blank';
                          });
                          print(error);
                        }
                      },
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
