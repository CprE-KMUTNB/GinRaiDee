// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/services.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';
import 'package:ginraid/Screens/HomeScreen/homescreenrequest.dart';
import 'package:ginraid/Screens/HomeScreen/menu_data.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homeScreen extends StatefulWidget {
  static const routeName = '/';

  const homeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homeScreenState();
  }
}

class _homeScreenState extends State<homeScreen> {
  late double screenWidth, screenHeight;
  final searchController = TextEditingController();
  Timer? timer;
  List item = [];

  Future<bool> setReset(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('reset', state);
  }

  Future<bool> checkReset() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool reset = await prefs.getBool('reset') ?? false;
    return reset;
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

  fetchdata() async {
    var response = await Allmenu().get('?search=' + searchController.text);

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
          'Home',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          bgHome1().buildBackground(screenWidth, screenHeight),

          //search
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 110, left: 25, right: 25),
            height: 40,
            child: TextField(
              controller: searchController,
              onChanged: (text) {
                fetchdata();
                setState(() {
                  item = [];
                });
              },
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 179, 190, 190),
                ),
                hintText: 'Search Foods',
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Itim",
                  color: Color.fromARGB(255, 179, 190, 190),
                ),
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Itim",
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),

          //กล่องใหญ่ไว้ใส่ card
          Container(
            margin: EdgeInsets.only(top: 170, left: 15, right: 15),
            height: 600,
            width: 500,
            //color: Colors.blueAccent,

            child: SingleChildScrollView(
                child: Column(children: <Widget>[getBody()])),
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
          return Post(
              id: MenuAll.fromJson(item[index]).id,
              owner: MenuAll.fromJson(item[index]).owner,
              ownerName: MenuAll.fromJson(item[index]).ownerName,
              ownerPic: MenuAll.fromJson(item[index]).ownerPic,
              isFollowing: MenuAll.fromJson(item[index]).isFollowing,
              foodname: MenuAll.fromJson(item[index]).foodname,
              foodpic: MenuAll.fromJson(item[index]).foodpic,
              ingredient: MenuAll.fromJson(item[index]).ingredient,
              recipes: MenuAll.fromJson(item[index]).recipes,
              isFavorites: MenuAll.fromJson(item[index]).isFavorites,
              favoritesCount: MenuAll.fromJson(item[index]).favoritesCount,
              created: MenuAll.fromJson(item[index]).created);
        });
  }
}
