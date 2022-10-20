import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Notification/NotiScreen.dart';
import 'package:ginraid/Screens/Cooking/myfoodScreen.dart';
import 'package:ginraid/Screens/Favorite/favoriteScreen.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen.dart';
import 'package:ginraid/Screens/SettingScreen/SettingScreen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';



class SalomonBottomNavBar extends StatefulWidget {
  const SalomonBottomNavBar({Key? key}) : super(key: key);

  @override
  _SalomonBottomNavBarState createState() => _SalomonBottomNavBarState();
}

class _SalomonBottomNavBarState extends State<SalomonBottomNavBar> {
  int _selectIndex = 0;
  PageController pageController = PageController();
  final List<Widget> _pageWidget = <Widget>[
        const homeScreen(),
        const favScreen(),
        const myFoodScreen(),
        const NotiScreen(),
        // const SettingScreen(),
    ];

  @override
  void onTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _selectIndex,
      onTap: (index) => setState(() => _selectIndex = index),
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
          selectedColor: Colors.purple,          
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text("Likes"),
          selectedColor: Colors.pink,
        ),

        /// Search
        SalomonBottomBarItem(
          icon: Icon(Icons.search),
          title: Text("Search"),
          selectedColor: Colors.orange,
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }

  
}
