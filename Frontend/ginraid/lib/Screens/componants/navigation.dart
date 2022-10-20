// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/%E0%B9%8C%E0%B9%8CNotification/NotiScreen.dart';
import 'package:ginraid/Screens/Cooking/myfoodScreen.dart';
import 'package:ginraid/Screens/Favorite/favoriteScreen.dart';
import 'package:ginraid/Screens/SettingScreen/SettingScreen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../HomeScreen/homeScreen.dart';

  
class Launcher extends StatefulWidget {
    static const routeName = '/';
 
    const Launcher({Key? key}) : super(key: key);
  
    @override
    State<StatefulWidget> createState() {
        return _LauncherState();
    }
}
  
class _LauncherState extends State<Launcher> {
    int _selectedIndex = 0;
    final List<Widget> _pageWidget = <Widget>[
        const homeScreen(),
        const favScreen(),
        const myFoodScreen(),
        const NotiScreen(),
        const SettingScreen(),
    ];
    final List<BottomNavigationBarItem> _menuBar
    =  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            // label: 'About',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            // label: 'Profile',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            // label: 'Contact',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
        ),
    ];
  
    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }
  
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: _pageWidget.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
                items: _menuBar,
                currentIndex: _selectedIndex,
                selectedItemColor: Theme
                    .of(context)
                    .primaryColor,
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
            ),
        );
    }
}