// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Favorite/favoriterequest.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
import 'package:ginraid/Screens/HomeScreen/reportPostScreen.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import '../HomeScreen/homeScreen3.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'https://ginraid.herokuapp.com/user-api/';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

Future<int> getID() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int id = await prefs.getInt('user_id')!;
  return id;
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

class follow {
  Client client = http.Client();
  Future<dynamic> post(dynamic object) async {
    var url = Uri.parse('${baseUrl}follow/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var _body = json.encode(object);
    var response = await client.post(url, body: _body, headers: _headers);
    if (response.statusCode == 201) {
      return response;
    }
    if (response.statusCode == 400) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }

  Future<dynamic> delete(int user) async {
    var url = Uri.parse('${baseUrl}followlist/${user}/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 204) {
      return response;
    }
    if (response.statusCode == 400) {
      print('Authentication credentials were not provided.');
    } else {
      print('fail');
    }
  }
}

class Post extends StatefulWidget {
  static const routeName = '/';
  int id;
  int owner;
  String ownerName;
  String ownerPic;
  bool isFollowing;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isFavorites;
  int favoritesCount;
  DateTime created;
  Post({
    required this.id,
    required this.owner,
    required this.ownerName,
    required this.ownerPic,
    required this.isFollowing,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isFavorites,
    required this.favoritesCount,
    required this.created,
  });

  @override
  _PostState createState() => _PostState(
      id: id,
      owner: owner,
      ownerName: ownerName,
      ownerPic: ownerPic,
      isFollowing: isFollowing,
      foodname: foodname,
      foodpic: foodpic,
      ingredient: ingredient,
      recipes: recipes,
      isFavorites: isFavorites,
      favoritesCount: favoritesCount,
      created: created);
}

class _PostState extends State<Post> {
  int id;
  int owner;
  String ownerName;
  String ownerPic;
  bool isFollowing;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isFavorites;
  int favoritesCount;
  DateTime created;
  _PostState({
    required this.id,
    required this.owner,
    required this.ownerName,
    required this.ownerPic,
    required this.isFollowing,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isFavorites,
    required this.favoritesCount,
    required this.created,
  });
  bool showbutton = false;
  bool isFollowedByMe = true;
  getid() async {
    if (await getID() != owner) {
      setState(() {
        showbutton = true;
      });
    } else {
      setState(() {
        showbutton = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getid();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    if (!showbutton) {
      return Container(
        // color: Colors.amber,
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        height: MediaQuery.of(context).size.height * 0.355,
        width: MediaQuery.of(context).size.width,
        child: Card(
          // color: Colors.amber,
          // ignore: sort_child_properties_last
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => homeScreen3(
                            owner: owner,
                            ownerName: ownerName,
                            ownerPic: ownerPic,
                            isFollowing: isFollowing,
                          ),
                        ),
                      ),
                    },
                    child: Row(
                      children: [
                        //??????????????????
                        Container(
                          // margin: EdgeInsets.only(top: 35),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 226, 226, 226),
                            image: DecorationImage(
                                image: NetworkImage(ownerPic),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(360)),
                          ),
                        ),
                        //????????????
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            ownerName,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Itim",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  
                ],
              ),

              //namemenu
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => homeScreen2(
                            id: id,
                            owner: owner,
                            ownerName: ownerName,
                            ownerPic: ownerPic,
                            isFollowing: isFollowing,
                            foodname: foodname,
                            foodpic: foodpic,
                            ingredient: ingredient,
                            recipes: recipes,
                            isFavorites: isFavorites,
                            favoritesCount: favoritesCount,
                            created: created)),
                  ),
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 5),
                      child: Text(
                        foodname,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "NotoSansThai",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // ],

                    //pic
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      height: 155,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(foodpic), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // SizedBox(width: 15),
                  Row(
                    children: [
                      TapDebouncer(
                        onTap: () async {
                          if (isFavorites == false) {
                            var response = await Favoritefood().post(id);
                            if (response.statusCode == 201) {
                              print('favorite');
                              setState(
                                () {
                                  isFavorites = !isFavorites;
                                  favoritesCount += 1;
                                  //?????????????????????           ?????????????????? ??????????????????
                                },
                              );
                            } else {
                              print('server down');
                            }
                          } else {
                            var response = await Favoritefood().delete(id);
                            if (response.statusCode == 204) {
                              print('unfavorite');
                              setState(
                                () {
                                  isFavorites = !isFavorites;
                                  favoritesCount -= 1;
                                  //?????????????????????           ?????????????????? ??????????????????
                                },
                              );
                            } else {
                              print('server down');
                            }
                          }
                        }, // your tap handler moved here
                        builder:
                            (BuildContext context, TapDebouncerFunc? onTap) {
                          return IconButton(
                              icon: Icon(
                                Icons.thumb_up,
                                color: isFavorites
                                    ? Color.fromARGB(255, 166, 198, 6)
                                    : Colors.black,
                              ),
                              onPressed: onTap);
                        },
                      ),
                      Text(
                        '$favoritesCount',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "NotoSansThai",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.report,
                        // size: 20.0,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      reportPostScreen(id: id)),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),

          elevation: 0,
        ),
      );
    } else {
      return Container(
        // color: Colors.amber,
        padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        height: MediaQuery.of(context).size.height * 0.355,
        width: MediaQuery.of(context).size.width,
        child: Card(
          // color: Colors.amber,
          // ignore: sort_child_properties_last
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => homeScreen3(
                            owner: owner,
                            ownerName: ownerName,
                            ownerPic: ownerPic,
                            isFollowing: isFollowing,
                          ),
                        ),
                      ),
                    },
                    child: Row(
                      children: [
                        //??????????????????
                        Container(
                          // margin: EdgeInsets.only(top: 35),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 226, 226, 226),
                            image: DecorationImage(
                                image: NetworkImage(ownerPic),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(360)),
                          ),
                        ),
                        //????????????
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            ownerName,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Itim",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //followbut
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => homeScreen3(
                            owner: owner,
                            ownerName: ownerName,
                            ownerPic: ownerPic,
                            isFollowing: isFollowing,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 110,
                      child: isFollowing
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Color.fromARGB(255, 166, 198, 6)),
                              ),
                              child: Center(
                                child: Text(
                                  'Following',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "IBMPlexSansThaiReg",
                                    color: Color.fromARGB(255, 166, 198, 6),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 166, 198, 6),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Follow',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "IBMPlexSansThaiReg",
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),

              //namemenu
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => homeScreen2(
                            id: id,
                            owner: owner,
                            ownerName: ownerName,
                            ownerPic: ownerPic,
                            isFollowing: isFollowing,
                            foodname: foodname,
                            foodpic: foodpic,
                            ingredient: ingredient,
                            recipes: recipes,
                            isFavorites: isFavorites,
                            favoritesCount: favoritesCount,
                            created: created)),
                  ),
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 5),
                      child: Text(
                        foodname,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "NotoSansThai",
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // ],

                    //pic
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      height: 155,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(foodpic), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 5,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // SizedBox(width: 15),
                  Row(
                    children: [
                      TapDebouncer(
                        onTap: () async {
                          if (isFavorites == false) {
                            var response = await Favoritefood().post(id);
                            if (response.statusCode == 201) {
                              print('favorite');
                              setState(
                                () {
                                  isFavorites = !isFavorites;
                                  favoritesCount += 1;
                                  //?????????????????????           ?????????????????? ??????????????????
                                },
                              );
                            } else {
                              print('server down');
                            }
                          } else {
                            var response = await Favoritefood().delete(id);
                            if (response.statusCode == 204) {
                              print('unfavorite');
                              setState(
                                () {
                                  isFavorites = !isFavorites;
                                  favoritesCount -= 1;
                                  //?????????????????????           ?????????????????? ??????????????????
                                },
                              );
                            } else {
                              print('server down');
                            }
                          }
                        }, // your tap handler moved here
                        builder:
                            (BuildContext context, TapDebouncerFunc? onTap) {
                          return IconButton(
                              icon: Icon(
                                Icons.thumb_up,
                                color: isFavorites
                                    ? Color.fromARGB(255, 166, 198, 6)
                                    : Colors.black,
                              ),
                              onPressed: onTap);
                        },
                      ),
                      Text(
                        '$favoritesCount',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "NotoSansThai",
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(
                        Icons.report,
                        // size: 20.0,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      reportPostScreen(id: id)),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),

          elevation: 0,
        ),
      );
    }
  }
}
