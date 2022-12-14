// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Favorite/bgFav3.dart';
import 'package:ginraid/Screens/Favorite/favfood.dart';
import 'package:ginraid/Screens/Favorite/favoritemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const String baseUrl = 'https://ginraid.herokuapp.com/menu-api/fav-list/';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

class Favoritelist {
  Client client = http.Client();
  Future<dynamic> get(String text) async {
    var url = Uri.parse(baseUrl + text);
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

class favFoodScreen extends StatefulWidget {
  static const routeName = '/';

  int followingvalue;
  int favoritevalue;
  favFoodScreen({
    required this.followingvalue,
    required this.favoritevalue,
  });

  @override
  State<StatefulWidget> createState() {
    return _favFoodScreenState(
        followingvalue: followingvalue, favoritevalue: favoritevalue);
  }
}

class _favFoodScreenState extends State<favFoodScreen> {
  int followingvalue;
  int favoritevalue;
  _favFoodScreenState({
    required this.followingvalue,
    required this.favoritevalue,
  });
  late double screenWidth, screenHeight;
  final searchController = TextEditingController();
  Timer? timer;
  List item = [];
  int itemvalue = 0;

  Future<bool> setReset(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('reset', state);
  }

  Future<bool> checkReset() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool reset = await prefs.getBool('reset') ?? false;
    return reset;
  }

  fetchsearchdata() async {
    var response = await Favoritelist().get('?search=' + searchController.text);

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        item = data;
        favoritevalue = item.length;
      });
    } else {
      setState(() {
        item = [];
      });
    }
  }

  fetchdata() async {
    var response = await Favoritelist().get('?ordering=-created');

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        item = data;
        favoritevalue = item.length;
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

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgfav3().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(
              top: 75,
            ),
            child: Column(
              children: [
                //row 1
                Row(
                  children: [
                    //????????????????????????????????? text
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        '????????????????????????????????? ',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "IBMPlexSansThaiReg",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),

                    //?????????????????????????????????????????????
                    // Container(
                    //   child: Text(
                    //     '$favoritevalue',
                    //     style: TextStyle(
                    //       fontSize: 25.0,
                    //       fontFamily: "IBMPlexSansThaiReg",
                    //       color: Color.fromARGB(255, 255, 255, 255),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                //searchFood
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    onChanged: (text) {},
                    onSubmitted: (text) {
                      if (searchController.text.isNotEmpty) {
                        fetchsearchdata();
                        setState(() {
                          item = [];
                        });
                      } else {
                        fetchdata();
                        setState(() {
                          item = [];
                        });
                      }
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

                //???????????????????????????
                Container(
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(47),
                      topLeft: Radius.circular(47),
                    ),
                  ),
                  height: screenHeight * 0.762,
                  width: screenWidth,
                  child:
                      //?????????????????????????????????????????????????????????????????????????????? ???????????????????????????
                      Container(
                    margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[getBody()],
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
        itemCount: item.length,
        itemBuilder: (context, index) {
          return favfood(
            id: Favorite.fromJson(item[index]).favMenu,
            owner: Favorite.fromJson(item[index]).ownerId,
            ownerName: Favorite.fromJson(item[index]).ownerName,
            ownerPic: Favorite.fromJson(item[index]).ownerPic,
            isFollowing: Favorite.fromJson(item[index]).isFollowing,
            foodname: Favorite.fromJson(item[index]).foodname,
            foodpic: Favorite.fromJson(item[index]).foodpic,
            ingredient: Favorite.fromJson(item[index]).ingredient,
            recipes: Favorite.fromJson(item[index]).recipes,
            isFavorites: Favorite.fromJson(item[index]).isFavorites,
            favoritesCount: Favorite.fromJson(item[index]).favoritesCount,
            created: Favorite.fromJson(item[index]).created,
            favoritesvalue: favoritevalue,
            followingvalue: followingvalue,
          );
        });
  }
}
