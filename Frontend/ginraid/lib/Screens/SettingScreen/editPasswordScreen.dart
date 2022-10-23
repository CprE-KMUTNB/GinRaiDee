// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/PicWid.dart';
import 'package:ginraid/Screens/Cooking/addFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook3.dart';
import 'package:ginraid/Screens/Cooking/food.dart';
import 'package:ginraid/Screens/Cooking/myFood.dart';
import 'package:ginraid/Screens/Cooking/textFieldwid.dart';
import 'package:ginraid/Screens/SettingScreen/ProfilePicWid.dart';
import 'package:ginraid/Screens/SettingScreen/bgSet.dart';
import 'package:ginraid/Screens/SettingScreen/settingrequest.dart';
import 'package:ginraid/Screens/SettingScreen/user.dart';
import 'package:image_picker/image_picker.dart';

class EditPasswordScreen extends StatefulWidget {
  static const routeName = '/';

  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditPasswordScreenState();
  }
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;
  String? _retrieveDataError;
  User user = UserPreferences.myUser;
  File? imageFile;
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final newpasswordconfirmController = TextEditingController();

  String oldpasswordError = ''; ////////////////////////////////////////////////
  String newpasswordError =
      ''; /////////////////////////////////////////////////
  String newpasswordconfirmError =
      ''; /////////////////////////////////////////////

  late double screenWidth, screenHeight;

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
          bgSet().buildBackground(screenWidth, screenHeight),
          Container(
            // color:Colors.amber,
            margin: EdgeInsets.only(top: 100),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  alignment: Alignment.topLeft,
                  // color: Colors.black,
                  child: Text(
                    'เปลี่ยนรหัสผ่าน',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "NotoSansThai",
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.lock_outline,
                    size: 35,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),

          //กล่องใหญ่
          Container(
            height: screenHeight * 0.74,
            margin: const EdgeInsets.only(top: 165),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //รหัสเก่า
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: oldpasswordController,
                      obscureText: _isObscure,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                _isObscure = !_isObscure;
                              },
                            );
                          },
                        ),
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
                        hintText: 'รหัสผ่านเก่า',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelText: 'รหัสผ่านเก่า',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  //รหัสใหม่
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: newpasswordController,
                      obscureText: _isObscure2,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure2
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                _isObscure2 = !_isObscure2;
                              },
                            );
                          },
                        ),
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
                        hintText: 'รหัสผ่านใหม่',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelText: 'รหัสผ่านใหม่',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  //ยืนยันรหัสใหม่
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: newpasswordconfirmController,
                      obscureText: _isObscure3,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure3
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                _isObscure3 = !_isObscure3;
                              },
                            );
                          },
                        ),
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
                        hintText: 'ยืนยันรหัสผ่านใหม่',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelText: 'ยืนยันรหัสผ่านใหม่',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  //ปุ่มบันทึก
                  Container(
                    width: 120,
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Color.fromARGB(255, 136, 68, 106),
                      ),
                      onPressed: () async {
                        var body = {
                          "old_password": oldpasswordController.text,
                          "password": newpasswordController.text,
                          "confirm_password": newpasswordconfirmController.text
                        };
                        var response = await Userdata().changepassword(body);
                        if (response.statusCode == 200) {
                          print('success change password');
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 1);
                        } else {
                          var error =
                              json.decode(utf8.decode(response.bodyBytes));
                          setState(() {
                            oldpasswordError = error["old_password"] == null
                                ? ''
                                : error["old_password"][0];
                            newpasswordError = error["password"] == null
                                ? ''
                                : error["password"][0];
                            newpasswordconfirmError =
                                error["confirm_password"] == null
                                    ? ''
                                    : error["confirm_password"][0];
                          });
                          print('oldpassword = ${oldpasswordError}');
                          print('newpassword = ${newpasswordError}');
                          print(
                              'confirmnewpassword = ${newpasswordconfirmError}');
                        }
                      },
                      child: const Text(
                        'บันทึก',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
