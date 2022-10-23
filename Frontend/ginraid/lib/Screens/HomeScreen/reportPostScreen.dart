// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook2.dart';
import 'package:ginraid/Screens/Cooking/foodrequest.dart';
import 'package:ginraid/Screens/HomeScreen/bgReport.dart';
import 'package:ginraid/Screens/HomeScreen/homescreenrequest.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reportPostScreen extends StatefulWidget {
  static const routeName = '/';

  int id;
  reportPostScreen({required this.id});

  @override
  State<StatefulWidget> createState() {
    return _reportPostScreenState(id: id);
  }
}

class _reportPostScreenState extends State<reportPostScreen> {
  final _formKey = GlobalKey<FormState>();
  late double screenWidth, screenHeight;
  int id;
  _reportPostScreenState({required this.id});
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
            margin: EdgeInsets.only(top: 75),
            child: Row(
              //แถว1
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //ชื่อหัวข้อ เพิ่มเมนูอาหาร
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'รายงานโพส',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "NotoSansThai",
                      color: Colors.white,
                    ),
                  ),
                ),

                Container(
                    child: Icon(
                  Icons.report,
                  size: 40,
                  color: Colors.white,
                )),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //กรอกเหตุผล
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล';
                          }
                          return null;
                        },
                        controller: reporttextcontroller,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.bottom,
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
                          hintText: 'เหตุผลที่รายงานโพสนี้',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 179, 190, 190),
                          ),
                          labelText: 'เหตุผลที่รายงานโพสนี้',
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 179, 190, 190),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),                          
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ),
                    ),

                    //ปุ่มยืนยัน
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
                          if (_formKey.currentState!.validate()) {//สำเร็จ
                            var response = await Report()
                                .post(reporttextcontroller.text, id);
                            if (response.statusCode == 201) {
                              showAlertDialog();
                              print('reportsuccess');
                            } else {
                              setState(() {
                                error = 'Server down';
                              });
                              print(error);
                            }
                          } else {
                            setState(() {//error
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
          ),
        ],
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'รายงานสำเร็จ',
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'ทางเราได้รับเรื่องเรียบร้อยแล้ว',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "NotoSansThai",
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 179, 190, 190)),
              onPressed: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
              child: const Text(
                'ตกลง',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "NotoSansThai",
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


}
