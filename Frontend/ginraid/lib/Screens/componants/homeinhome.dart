// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ginraid/Screens/Favorite/favoriteScreen.dart';

import 'package:ginraid/Screens/Notification/NotiScreen.dart';
import 'package:ginraid/Screens/SettingScreen/SettingScreen.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Cooking/myfoodScreen.dart';
import '../HomeScreen/homeScreen.dart';
import 'package:http/http.dart' as http;

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

class Notilist {
  Client client = http.Client();
  Future<dynamic> get() async {
    var url = Uri.parse('https://ginraid.herokuapp.com/notification-api/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response;
    }
    if (response.statusCode == 401) {
      return response;
    } else {
      print('fail');
    }
  }
}

class homeinScreen extends StatefulWidget {
  static const routeName = '/';

  const homeinScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homeinScreenState();
  }
}

class _homeinScreenState extends State<homeinScreen> {
  int _selectIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    homeScreen(),
    favScreen(),
    myFoodScreen(),
    NotiScreen(),
    SettingScreen(),
  ];
  late double screenWidth, screenHeight;
  final searchController = TextEditingController();
  Timer? timer;
  List item = [];
  int notivalue = 0;
  bool hasnoti = false;

  checknoti() async {
    var response = await Notilist().get();
    if (response != null) {
      if (response.statusCode == 200) {
        var data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          item = data;
          notivalue = item.length;
        });
        if (item.isNotEmpty) {
          setState(() {
            hasnoti = true;
          });
        } else {
          setState(() {
            hasnoti = false;
          });
        }
      }
    } else {
      setState(() {
        hasnoti = false;
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => checknoti());
    checknoti();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    if (hasnoti) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: _pageWidget[_selectIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectIndex,
          onTap: (index) => setState(() => _selectIndex = index),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Itim",
                ),
              ),
              selectedColor: Color.fromARGB(255, 166, 198, 6),
            ),

            /// Fav
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text(
                "Likes",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Itim",
                ),
              ),
              selectedColor: Color.fromARGB(255, 224, 132, 106),
            ),

            /// cooking
            SalomonBottomBarItem(
              icon: Icon(Icons.fastfood_outlined),
              title: Text(
                "Cooking",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Itim",
                ),
              ),
              selectedColor: Color.fromARGB(255, 246, 170, 72),
            ),

            /// Noti
            SalomonBottomBarItem(
              icon: Stack(
                children: <Widget>[
                  Icon(Icons
                      .notifications_none_outlined), ///////////////////////////////////noti icpn
                  Positioned(
                      child: Icon(
                    Icons.brightness_1,
                    color: Colors.red,
                    size: 9.0,
                  ))
                ],
              ),
              title: Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: "Itim",
                ),
              ),
              selectedColor: Color.fromARGB(255, 234, 225, 9),
            ),

            //Setting
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                "Setting",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: "Itim",
                ),
              ),
              selectedColor: Color.fromARGB(255, 122, 57, 88),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageWidget[_selectIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectIndex,
        onTap: (index) => setState(() => _selectIndex = index),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Itim",
              ),
            ),
            selectedColor: Color.fromARGB(255, 166, 198, 6),
          ),

          /// Fav
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(
              "Likes",
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Itim",
              ),
            ),
            selectedColor: Color.fromARGB(255, 224, 132, 106),
          ),

          /// cooking
          SalomonBottomBarItem(
            icon: Icon(Icons.fastfood_outlined),
            title: Text(
              "Cooking",
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Itim",
              ),
            ),
            selectedColor: Color.fromARGB(255, 246, 170, 72),
          ),

          /// Noti
          SalomonBottomBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            title: Text(
              "Notifications",
              style: TextStyle(
                fontSize: 10,
                fontFamily: "Itim",
              ),
            ),
            selectedColor: Color.fromARGB(255, 234, 225, 9),
          ),

          //Setting
          SalomonBottomBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              "Setting",
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: "Itim",
              ),
            ),
            selectedColor: Color.fromARGB(255, 122, 57, 88),
          ),
        ],
      ),
    );
  }
}
