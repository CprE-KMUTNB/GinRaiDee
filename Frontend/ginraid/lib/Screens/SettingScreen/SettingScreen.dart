// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';
import 'package:ginraid/Screens/Notification/bgNoti.dart';
import 'package:ginraid/Screens/Notification/notiCard.dart';
import 'package:ginraid/Screens/Favorite/bgFav3.dart';
import 'package:ginraid/Screens/Favorite/favfood.dart';
import 'package:ginraid/Screens/SettingScreen/bgSet.dart';
import 'package:ginraid/Screens/SettingScreen/editPasswordScreen.dart';
import 'package:ginraid/Screens/SettingScreen/editProfileScreen.dart';
import 'package:ginraid/Screens/SettingScreen/settingrequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user_id');
  await prefs.remove('username');
  var success = await prefs.remove('token');
  return success;
}

Future<dynamic> setUsername(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('username', value);
}

Future<String> getUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String username = await prefs.getString('username').toString();
  return username;
}

Future<int> getID() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int userID = await prefs.getInt('user_id')!;
  return userID;
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
  Timer? timer;
  String username = "";
  int follower = 0;
  int food = 0;
  String userpic =
      'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png';

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) => isreset());
    fetchdata();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  fetchdata() async {
    var response = await Userdata().get();

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        username = data["username"];
        follower = data["follower_count"];
        food = data["menu"].length;
        userpic = data["userpic"] == null
            ? 'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'
            : data["userpic"];
      });
    }
  }

  Future<bool> setReset(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('reset', state);
  }

  Future<bool> checkReset() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool reset = await prefs.getBool('reset') ?? false;
    return reset;
  }

  isreset() async {
    if (await checkReset() == true) {
      fetchdata();
      await setReset(false);
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
        automaticallyImplyLeading: false,
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
                          builder: (context) => EditProfileScreen(
                              username: username, userPic: userpic)),
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
                                  // margin: EdgeInsets.only(top: 35),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 226, 226, 226),
                                    image: DecorationImage(
                                        image: NetworkImage(userpic),
                                        fit: BoxFit.cover),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(360)),
                                  ),
                                ),

                                //ชื่อ
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    username,
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
                                    '$follower',
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
                                    '$food',
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => loginScreen()),
                        (Route<dynamic> route) => false);
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
              onPressed: () async {
                var response = await Userdata().deleteaccount();
                if (response.statusCode == 204) {
                  print('delete is success');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => loginScreen()),
                      (Route<dynamic> route) => false);
                }
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
