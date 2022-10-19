import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/myfoodScreen.dart';
import 'package:ginraid/Screens/Favorite/favoriteScreen.dart';
import 'package:ginraid/Screens/Favorite/followingScreen.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen3.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';
import 'package:ginraid/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/material/progress_indicator.dart';

import 'Screens/Signup/Signup_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/material/progress_indicator.dart';

void main() {
  runApp(NotAuthen());
}

class NotAuthen extends StatelessWidget {
  // This widget is the root of your application.
  Future<Widget> getWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final success = await prefs.remove('token');
    String token = await prefs.getString('token') ?? '';
    if (token == '') {
      return loginScreen();
    } else {
      return homeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primaryColor: authenPriColor,
        scaffoldBackgroundColor: Color(0xFFF1F7E7),
      ),
      home: FutureBuilder(
        future: getWidget(),
        builder: (BuildContext context, AsyncSnapshot<Widget> widget) {
          if (widget.hasData) {
            return widget.data ?? loginScreen();
          } else {
            return const Center(child: CircularProgressIndicator());
            // loginScreen());
            // home: signupScreen());
            // home: homeScreen());
            // home: favScreen());
            //  home: followingScreen());
          }
        },
      ),
    );
  }
}
