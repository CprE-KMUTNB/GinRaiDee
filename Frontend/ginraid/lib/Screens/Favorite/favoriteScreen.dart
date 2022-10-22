// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ginraid/Screens/Favorite/bgFav1.dart';
import 'package:ginraid/Screens/Favorite/favfood.dart';
import 'package:ginraid/Screens/Favorite/favoriteFoodScreen.dart';
import 'package:ginraid/Screens/Favorite/favoritemodel.dart';
import 'package:ginraid/Screens/Favorite/followingScreen.dart';
import 'package:ginraid/Screens/SettingScreen/editProfileScreen.dart';
import 'package:ginraid/Screens/SettingScreen/settingrequest.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

Future<String> getUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String username = await prefs.getString('username').toString();
  return username;
}

class Favoritelist {
  Client client = http.Client();
  Future<dynamic> get() async {
    var url = Uri.parse('https://ginraid.herokuapp.com/menu-api/fav-list/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }
}

class Followinglist {
  Client client = http.Client();
  Future<dynamic> get() async {
    var url = Uri.parse('https://ginraid.herokuapp.com/user-api/followlist/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }
}

class favScreen extends StatefulWidget {
  static const routeName = '/';

  const favScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _favScreenState();
  }
}

class _favScreenState extends State<favScreen> {
  late double screenWidth, screenHeight;
  List item = [];
  List followitem = [];
  String username = "";
  String? userpic;
  Timer? timer;

  fetchuserpic() async {
    var response = await Userdata().get();
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        userpic = data["userpic"] ??
            'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png';
      });
    }
  }

  fetchdata() async {
    var response = await Favoritelist().get();
    var name = await getUsername();
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        item = data;
        username = name;
      });
    } else {
      setState(() {
        item = [];
        username = name;
      });
    }
  }

  fetchfollow() async {
    var response = await Followinglist().get();
    var name = await getUsername();
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        followitem = data;
        username = name;
      });
    } else {
      setState(() {
        followitem = [];
        username = name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) => isreset());
    fetchdata();
    fetchuserpic();
    fetchfollow();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
      fetchfollow();
      setState(() {
        item = [];
        followitem = [];
      });
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Your Favorites',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          bgfav1().buildBackground(screenWidth, screenHeight),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 90,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  //แถวแรก
                  child: Row(
                    children: [
                      //profile pic
                      Container(
                        // margin: EdgeInsets.only(top: 35),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 226, 226, 226),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(360)),
                        ),
                      ),

                      //ข้อมูลชื่อไฟล์
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //name profile
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              username,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "Itim",
                                color: Colors.white,
                              ),
                            ),
                          ),

                          //edit profile button
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 5, left: 22),
                            height: 30,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfileScreen(
                                        username: username, userPic: userpic!),
                                  ),
                                );
                              },
                              child: const Text(
                                ' Edit Profile ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: "Itim",
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //แถว2
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //จำนวน กำลังติดตาม
                      Container(
                        width: screenWidth * 0.5,
                        child: Text(
                          '${followitem.length}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Itim",
                            color: Colors.white,
                          ),
                        ),
                      ),

                      //จำนวน อาหารที่ชอบ
                      Container(
                        child: Text(
                          '${item.length}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Itim",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //แถว 3
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //ปุ่มกำลังติดตาม
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 39,
                        width: 130,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            backgroundColor: Color.fromARGB(255, 251, 147, 117),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    followingScreen(isFollowing: true),
                              ),
                            );
                          },
                          child: const Text(
                            ' กำลังติดตาม ',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "IBMPlexSansThai",
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.15,
                      ),

                      //ปุ่มรายการอาหารที่ชอบ
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        height: 39,
                        width: 130,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            backgroundColor: Color.fromARGB(255, 251, 147, 117),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const favFoodScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            ' อาหารที่ชอบ ',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "IBMPlexSansThai",
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //แถวที่ 4

                Container(
                  margin: EdgeInsets.only(top: 35, left: 20),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'My favorites ',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "Itim",
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        '${item.length}',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "Itim",
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),

                //post
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    // borderRadius: BorderRadius.only(
                    //   topRight: Radius.circular(47),
                    //   topLeft: Radius.circular(47),
                    // ),
                  ),
                  height: screenHeight * 0.555,
                  width: screenWidth,
                  child:
                      //กล่องที่ใส่เมนูที่ถูกใจไว้ กล่องใหญ่
                      Container(
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          //post ที่ถูกใจ
                          getBody()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (context, index) {
          return favfood(
              id: Favorite.fromJson(item[index]).favMenu,
              owner: Favorite.fromJson(item[index]).ownerId,
              ownerName: Favorite.fromJson(item[index]).ownerName,
              ownerPic: Favorite.fromJson(item[index]).ownerPic,
              isFollowing: Favorite.fromJson(item[index]).isFollowing,
              foodname: Favorite.fromJson(item[index]).foodname,
              foodpic: Favorite.fromJson(item[index]).foodpic,
              ingredient: Favorite.fromJson(item[index]).ingredient,
              recipes: Favorite.fromJson(item[index]).recipes,
              isFavorites: Favorite.fromJson(item[index]).isFavorites,
              favoritesCount: Favorite.fromJson(item[index]).favoritesCount,
              created: Favorite.fromJson(item[index]).created);
        });
  }
}
