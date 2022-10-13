import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';
import 'package:ginraid/constant.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/Signup/Signup_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // primaryColor: authenPriColor,
          scaffoldBackgroundColor: Color(0xFFF1F7E7),
        ),
        // home: loginScreen());
        // home: signupScreen());
        home: homeScreen());
  }
}
