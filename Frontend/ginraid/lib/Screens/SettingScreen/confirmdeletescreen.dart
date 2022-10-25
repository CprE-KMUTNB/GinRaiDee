import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';
import 'package:ginraid/Screens/SettingScreen/bgSet.dart';
import 'package:ginraid/Screens/SettingScreen/settingrequest.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  static const routeName = '/';

  const ConfirmPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConfirmPasswordScreenState();
  }
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String? _retrieveDataError;
  final oldpasswordController = TextEditingController();

  String oldpasswordError = ''; ////////////////////////////////////////////////
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
                    'ยืนยันรหัสผ่าน',
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //รหัสเก่า
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล';
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

                    //รหัสใหม่

                    //ปุ่มบันทึก
                    Container(
                      width: 120,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      child: TapDebouncer(
                        onTap: () async {
                          var body = {
                            "old_password": oldpasswordController.text,
                            "password": oldpasswordController.text,
                            "confirm_password": oldpasswordController.text
                          };
                          var response = await Userdata().changepassword(body);
                          if (_formKey.currentState!.validate()) {
                            if (response.statusCode == 200) {
                              print('password confirm');
                              showAlertDialog();
                            }
                          }
                          if (response.statusCode == 400) {
                            var error =
                                json.decode(utf8.decode(response.bodyBytes));
                            setState(() {
                              oldpasswordError = error["old_password"] == null
                                  ? ''
                                  : error["old_password"][0];
                            });
                            if (oldpasswordError == "Incorrect Password!") {
                              showError();
                            }
                            print('oldpassword = ${oldpasswordError}');
                          }
                        }, // your tap handler moved here
                        builder:
                            (BuildContext context, TapDebouncerFunc? onTap) {
                          return TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Color.fromARGB(255, 253, 0, 0),
                            ),
                            onPressed: onTap,
                            child: const Text(
                              'ยืนยัน',
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
            "รหัสผ่านเก่าผิด",
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "NotoSansThai",
                fontWeight: FontWeight.bold
                // color: Color.fromARGB(255, 166, 198, 6),
                ),
          ),
          content: Text(
            'กรุณาลองใหม่อีกครั้ง',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "NotoSansThai",
              // color: Color.fromARGB(255, 166, 198, 6),
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: const Text(
                "ตกลง",
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

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'ลบบัญชี',
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'คุณต้องการที่จะลบบัญชีนี้',
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
                Navigator.pop(context);
              },
              child: const Text(
                'ยกเลิก',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "NotoSansThai",
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            TapDebouncer(
              onTap: () async {
                var response = await Userdata().deleteaccount();
                if (response.statusCode == 204) {
                  print('delete is success');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => loginScreen()),
                      (Route<dynamic> route) => false);
                }
              }, // your tap handler moved here
              builder: (BuildContext context, TapDebouncerFunc? onTap) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: onTap,
                  child: const Text(
                    'ลบบัญชี',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "NotoSansThai",
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
