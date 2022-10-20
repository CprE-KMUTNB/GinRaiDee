// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../HomeScreen/homeScreen3.dart';

const String baseUrl = 'https://ginraid.herokuapp.com/user-api/';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

Future<bool> setReset(bool state) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('reset', state);
}

Future<bool> setResetFollowing(bool state) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('resetfollowing', state);
}

Future<bool> checkReset() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool reset = await prefs.getBool('reset') ?? false;
  return reset;
}

class unfollow {
  Client client = http.Client();
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

class follow extends StatefulWidget {
  static const routeName = '/';

  int owner;
  String ownerName;
  String ownerPic;
  DateTime created;
  bool isFollowing;
  follow(
      {required this.owner,
      required this.ownerName,
      required this.ownerPic,
      required this.created,
      required this.isFollowing});

  @override
  State<StatefulWidget> createState() {
    return _followState(
        owner: owner,
        ownerName: ownerName,
        ownerPic: ownerPic,
        created: created,
        isFollowing: isFollowing);
  }
}

class _followState extends State<follow> {
  int owner;
  String ownerName;
  String ownerPic;
  DateTime created;
  bool isFollowing;
  _followState(
      {required this.owner,
      required this.ownerName,
      required this.ownerPic,
      required this.created,
      required this.isFollowing});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2, left: 5, right: 5),
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Color.fromARGB(255, 248, 248, 248),
        // ignore: sort_child_properties_last
        child: Row(
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
                          )),
                ),
              },
              child: Row(
                children: [
                  //profile pic
                  Container(
                    // margin: EdgeInsets.only(top: 35),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 226, 226, 226),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(360)),
                    ),
                  ),

                  //user name
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      ownerName,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Itim",
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //ปุ่มฟอล
            Container(
              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  var response = await unfollow().delete(owner);
                  if (response.statusCode == 204) {
                    await setReset(true);
                    await setResetFollowing(true);
                    print('unfollow');
                    setState(
                      () {
                        isFollowing = !isFollowing;
                        //ฟอลอยู่           ไม่ฟอล อัลฟอล
                      },
                    );
                  } else {
                    print('server down');
                  }
                },
                child: AnimatedContainer(
                  height: 35,
                  width: 110,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isFollowing
                        ? Colors.transparent
                        : Color.fromARGB(255, 224, 132, 106),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isFollowing
                          ? Color.fromARGB(255, 224, 132, 106)
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isFollowing ? 'Following' : 'Follow',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: "IBMPlexSansThaiReg",
                        color: isFollowing
                            ? Color.fromARGB(255, 224, 132, 106)
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        elevation: 0,
      ),
    );
  }
}
