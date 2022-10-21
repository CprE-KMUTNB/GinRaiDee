// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';
import 'package:ginraid/Screens/Notification/bgNoti.dart';
import 'package:ginraid/Screens/Notification/notiCard.dart';
import 'package:ginraid/Screens/Favorite/bgFav3.dart';
import 'package:ginraid/Screens/Favorite/favfood.dart';
import 'package:ginraid/Screens/SettingScreen/bgSet.dart';
import 'package:ginraid/Screens/SettingScreen/editPasswordScreen.dart';
import 'package:ginraid/Screens/SettingScreen/editProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final success = await prefs.remove('token');
  return success;
}

class SettingScreen extends StatefulWidget {
  static const routeName = '/';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingScreenState();
  }
}

class _SettingScreenState extends State<SettingScreen> {
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
          'Setting',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          bgSet().buildBackground(screenWidth, screenHeight),
          Container(
            // color:Colors.amber,
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  // color: Colors.black,
                  child: Text(
                    'โปรไฟล์ของฉัน',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "NotoSansThai",
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),

                //profile
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()),
                    ),
                  },
                  child: Container(
                    width: screenWidth * 0.9,
                    height: 100,
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //แถว1
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                //รูปโปร
                                Container(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 50.0,
                                  ),
                                ),
                                //ชื่อ
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'User 1',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "NotoSansThai",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(
                                'แก้ไขโปรไฟล์',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "NotoSansThai",
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            )
                          ],
                        ),
                        //แถว2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    'ผู้ติดตาม : ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "NotoSansThai",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),

                                //รับค่าจำนวนผู้ติดตาม
                                Container(
                                  child: Text(
                                    '4',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "NotoSansThai",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),

                                Container(
                                  child: Text(
                                    ' คน',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "NotoSansThai",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text(
                                    'เมนูอาหาร : ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "NotoSansThai",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),

                                //รับค่าจำนวนเมนูอาหาร
                                Container(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "NotoSansThai",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),

                                Container(
                                  child: Text(
                                    ' รายการ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "NotoSansThai",
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                //รหัสผ่าน
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditPasswordScreen()),
                    ),
                  },
                  child: Container(
                    width: screenWidth * 0.9,
                    height: 100,
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 50,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'รหัสผ่านและความปลอดภัย',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //ออกจากระบบ
                GestureDetector(
                  onTap: () async {
                    await logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const loginScreen()),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.9,
                    height: 100,
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'ออกจากระบบ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //ลบบัญชี
                GestureDetector(
                  onTap: () => {showAlertDialog()},
                  child: Container(
                    width: screenWidth * 0.9,
                    height: 100,
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 50,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'ลบบัญชี',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      ],
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                // Write code to delete item
              },
              child: const Text(
                'ลบบัญชี',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "NotoSansThai",
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
