import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/services.dart';
import 'package:ginraid/Screens/Favorite/favoriteScreen.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';
import 'package:ginraid/Screens/HomeScreen/homescreenrequest.dart';
import 'package:ginraid/Screens/HomeScreen/menu_data.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';
import 'package:ginraid/Screens/SettingScreen/SettingScreen.dart';
import 'package:ginraid/Screens/componants/salmon.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Cooking/myfoodScreen.dart';
import '../HomeScreen/homeScreen.dart';
import '../์์Notification/NotiScreen.dart';

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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

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
          title: Text("Home"),
          selectedColor: Color.fromARGB(255, 166, 198, 6),          
        ),

        /// Fav
        SalomonBottomBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text("Likes"),
          selectedColor: Color.fromARGB(255, 224, 132, 106),
        ),

        /// cooking
        SalomonBottomBarItem(
          icon: Icon(Icons.search),
          title: Text("Cooking"),
          selectedColor: Color.fromARGB(255, 246, 170, 72),
        ),

        /// Noti
        SalomonBottomBarItem(
          icon: Icon(Icons.notifications_none_outlined),
          title: Text("Notifications"),
          selectedColor: Color.fromARGB(255, 234, 225, 9),
        ),

        //Setting
        SalomonBottomBarItem(
          icon: Icon(Icons.hail),
          title: Text("Setting"),
          selectedColor: Color.fromARGB(255, 72, 99, 81),
        ),
      ],
    ),
      
    );
  }
}
