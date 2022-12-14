// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/SettingScreen/bgSet.dart';
import 'package:ginraid/Screens/SettingScreen/settingrequest.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class EditPasswordScreen extends StatefulWidget {
  static const routeName = '/';

  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditPasswordScreenState();
  }
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool _isObscure3 = true;
  String? _retrieveDataError;
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
                    '?????????????????????????????????????????????',
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

          //???????????????????????????
          Container(
            height: screenHeight * 0.74,
            margin: const EdgeInsets.only(top: 165),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //????????????????????????
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '?????????????????????????????????????????????';
                          }
                          return null;
                        },
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
                          hintText: '????????????????????????????????????',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 179, 190, 190),
                          ),
                          labelText: '????????????????????????????????????',
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ),
                    ),

                    //????????????????????????
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '?????????????????????????????????????????????';
                          }
                          return null;
                        },
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
                          hintText: '????????????????????????????????????',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 179, 190, 190),
                          ),
                          labelText: '????????????????????????????????????',
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ),
                    ),

                    //??????????????????????????????????????????
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '?????????????????????????????????????????????';
                          }
                          if (value != newpasswordController.text) {
                            return '???????????????????????????????????????????????????';
                          }
                          return null;
                        },
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
                          hintText: '??????????????????????????????????????????????????????',
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 179, 190, 190),
                          ),
                          labelText: '??????????????????????????????????????????????????????',
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ),
                    ),

                    //??????????????????????????????
                    Container(
                      width: 120,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      child: TapDebouncer(
                        onTap: () async {
                          var body = {
                            "old_password": oldpasswordController.text,
                            "password": newpasswordController.text,
                            "confirm_password":
                                newpasswordconfirmController.text
                          };
                          var response = await Userdata().changepassword(body);
                          if (_formKey.currentState!.validate()) {
                            if (response.statusCode == 200) {
                              print('success change password');
                              int count = 0;
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 1);
                            }
                          }
                          if (response.statusCode == 400) {
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
                            if (oldpasswordError == "Incorrect Password!") {
                              showError();
                            }
                            print('oldpassword = ${oldpasswordError}');
                            print('newpassword = ${newpasswordError}');
                            print(
                                'confirmnewpassword = ${newpasswordconfirmError}');
                          }
                        }, // your tap handler moved here
                        builder:
                            (BuildContext context, TapDebouncerFunc? onTap) {
                          return TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 136, 68, 106),
                            ),
                            onPressed: onTap,
                            child: const Text(
                              '??????????????????',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "NotoSansThai",
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "?????????????????????????????????????????????",
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "NotoSansThai",
                fontWeight: FontWeight.bold
                // color: Color.fromARGB(255, 166, 198, 6),
                ),
          ),
          content: Text(
            '????????????????????????????????????????????????????????????',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "NotoSansThai",
              // color: Color.fromARGB(255, 166, 198, 6),
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: const Text(
                "????????????",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Itim",
                  color: Color.fromARGB(255, 166, 198, 6),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
