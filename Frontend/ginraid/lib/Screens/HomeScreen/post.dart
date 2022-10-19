import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
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

class follow {
  Client client = http.Client();
  Future<dynamic> post(dynamic object) async {
    var url = Uri.parse('${baseUrl}follow/');
    var _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${await getToken()}',
    };
    var _body = json.encode(object);
    print(_body);
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

  bool isFollowedByMe = true;
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      height: MediaQuery.of(context).size.height * 0.35,
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
                          builder: (context) => const homeScreen3()),
                    ),
                  },
                  child: Row(
                    children: [
                      //รูปโปร
                      Container(
                        child: Icon(
                          Icons.account_circle,
                          size: 45.0,
                        ),
                      ),
                      //ชื่อ
                      Container(
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
                Container(
                  margin: EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      if (isFollowing == false) {
                        var followid = {"following": owner};
                        var response = await follow().post(followid);
                        if (response.statusCode == 201) {
                          print('follow');
                          setState(
                            () {
                              isFollowing = !isFollowing;
                              //ฟอลอยู่           ไม่ฟอล อัลฟอล
                            },
                          );
                        } else {
                          print('server down');
                        }
                      } else {
                        var response = await follow().delete(owner);
                        if (response.statusCode == 204) {
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
                      }
                    },
                    child: AnimatedContainer(
                      height: 35,
                      width: 110,
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: isFollowing
                            ? Colors.transparent
                            : Color.fromARGB(255, 166, 198, 6),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isFollowing
                              ? Color.fromARGB(255, 166, 198, 6)
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
                                ? Color.fromARGB(255, 166, 198, 6)
                                : Color.fromARGB(255, 255, 255, 255),
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
                  MaterialPageRoute(builder: (context) => const homeScreen2()),
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
            SizedBox(
              height: 10,
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(width: 15),
                Icon(
                  Icons.thumb_up,
                  size: 20.0,
                ),
                SizedBox(width: 250),
                Icon(
                  Icons.report,
                  size: 20.0,
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
