import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/componants/homeinhome.dart';

void main() {
  runApp(NotAuthen());
}

class NotAuthen extends StatefulWidget {
  static final title = 'salomon_bottom_bar';
  _NotAuthenState createState() => _NotAuthenState();
  // This widget is the root of your application.

}

class _NotAuthenState extends State<NotAuthen> {
  Future<Widget> getWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final success = await prefs.remove('token');
    String token = await prefs.getString('token') ?? '';
    if (token == '') {
      return loginScreen();
    } else {
      return homeinScreen();
    }
  }

  var _currentIndex = 0;

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
//hi