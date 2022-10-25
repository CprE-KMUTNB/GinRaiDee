// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ginraid/Screens/Favorite/bgFav2.dart';
import 'package:ginraid/Screens/Favorite/favoritemodel.dart';
import 'package:ginraid/Screens/Favorite/following.dart';
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

class Followinglist {
  Client client = http.Client();
  Future<dynamic> get() async {
    var url = Uri.parse(
        'https://ginraid.herokuapp.com/user-api/followlist/?ordering=-created');
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

class followingScreen extends StatefulWidget {
  static const routeName = '/';

  bool isFollowing;
  followingScreen({
    required this.isFollowing,
  });

  @override
  State<StatefulWidget> createState() {
    return _followingScreenState(isFollowing: isFollowing);
  }
}

class _followingScreenState extends State<followingScreen> {
  bool isFollowing;
  _followingScreenState({
    required this.isFollowing,
  });
  late double screenWidth, screenHeight;

  List followitem = [];
  String username = "loading";
  Timer? timer;

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
    fetchfollow();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
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
      fetchfollow();
      setState(() {
        followitem = [];
      });
      await setReset(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    var choice;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgfav2().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(
              top: 75,
            ),
            child: Column(
              children: [
                //row 1
                Row(
                  children: [
                    //กำลังติดตาม text
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'กำลังติดตาม ',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "IBMPlexSansThaiReg",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //จำนวนกำลังติดตาม
                    // Container(
                    //   child: Text(
                    //     '${followitem.length}',
                    //     style: TextStyle(
                    //       fontSize: 25.0,
                    //       fontFamily: "IBMPlexSansThaiReg",
                    //       color: Color.fromARGB(255, 255, 255, 255),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                //searchUser
                // Container(
                //   alignment: Alignment.center,
                //   margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                //   height: 40,
                //   child: TextField(
                //     textAlignVertical: TextAlignVertical.bottom,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       filled: true,
                //       fillColor: Color.fromARGB(255, 255, 255, 255),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color.fromARGB(255, 255, 255, 255),
                //         ),
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color.fromARGB(255, 255, 255, 255),
                //         ),
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       prefixIcon: Icon(
                //         Icons.search,
                //         color: Color.fromARGB(255, 179, 190, 190),
                //       ),
                //       hintText: 'Search User',
                //       hintStyle: TextStyle(
                //         fontSize: 20.0,
                //         fontFamily: "Itim",
                //         color: Color.fromARGB(255, 179, 190, 190),
                //       ),
                //       labelStyle: TextStyle(
                //         fontSize: 20.0,
                //         fontFamily: "Itim",
                //         color: Color.fromARGB(255, 0, 0, 0),
                //       ),
                //     ),
                //   ),
                // ),

                //กล่องใหญ่
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(47),
                      topLeft: Radius.circular(47),
                    ),
                  ),
                  height: screenHeight * 0.835,
                  width: screenWidth,
                  child:
                      //กล่องที่ใส่คนที่ฟอล กล่องใหญ่
                      Container(
                    margin: EdgeInsets.only(top: 19),
                    child: SingleChildScrollView(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          //คนที่ฟอล
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
        itemCount: followitem.length,
        itemBuilder: (context, index) {
          return follow(
            owner: Follow.fromJson(followitem[index]).following,
            ownerName: Follow.fromJson(followitem[index]).followingname,
            ownerPic: Follow.fromJson(followitem[index]).followingpic,
            created: Follow.fromJson(followitem[index]).created,
            isFollowing: isFollowing,
          );
        });
  }
}
