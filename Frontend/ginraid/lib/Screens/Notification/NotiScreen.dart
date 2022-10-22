// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Notification/notimodel.dart';
import 'package:ginraid/Screens/Notification/bgNoti.dart';
import 'package:ginraid/Screens/Notification/notiCard.dart';
import 'package:ginraid/Screens/Favorite/bgFav3.dart';
import 'package:ginraid/Screens/Favorite/favfood.dart';
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
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }

  Future<dynamic> delete(int item) async {
    var url =
        Uri.parse('https://ginraid.herokuapp.com/notification-api/$item/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 204) {
      return response;
    }
    if (response.statusCode == 401) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }
}

class NotiScreen extends StatefulWidget {
  static const routeName = '/';

  const NotiScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NotiScreenState();
  }
}

Future<bool> setNotiReset(bool state) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('notireset', state);
}

Future<bool> checkNotiReset() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool reset = await prefs.getBool('notireset') ?? false;
  return reset;
}

class _NotiScreenState extends State<NotiScreen> {
  late double screenWidth, screenHeight;
  List item = [];
  Timer? timer;

  fetchdata() async {
    var response = await Notilist().get();
    var name = await getUsername();
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        item = data;
      });
    } else {
      setState(() {
        item = [];
      });
    }
  }

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
      setState(() {
        item = [];
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          bgNoti().buildBackground(screenWidth, screenHeight),
          Container(
            height: screenHeight * 0.82,
            width: screenWidth,
            margin: EdgeInsets.only(top: 90),
            padding: EdgeInsets.only(top: 10, right: 10, left: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(47),
                topLeft: Radius.circular(47),
              ),
            ),
            child: Column(
              children: [
                Container(
                  // color: Colors.amber,
                  // margin: EdgeInsets.only(left: 15, right: 15),
                  // height: 560,
                  width: screenWidth,
                  height: screenHeight * 0.8,
                  // color: Colors.blueAccent,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      //1post
                      getBody(context)
                    ]

                        //post

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

  Widget getBody(context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (context, index) {
          return noti(
              context,
              Notificationmodel.fromJson(item[index]).id,
              Notificationmodel.fromJson(item[index]).information,
              Notificationmodel.fromJson(item[index]).sender,
              Notificationmodel.fromJson(item[index]).senderName,
              Notificationmodel.fromJson(item[index]).senderPic,
              Notificationmodel.fromJson(item[index]).isFollowing,
              Notificationmodel.fromJson(item[index]).foodname,
              Notificationmodel.fromJson(item[index]).foodpic,
              Notificationmodel.fromJson(item[index]).ingredient,
              Notificationmodel.fromJson(item[index]).recipes,
              Notificationmodel.fromJson(item[index]).isFavorites,
              Notificationmodel.fromJson(item[index]).favoritesCount,
              Notificationmodel.fromJson(item[index]).created);
        });
  }
}
