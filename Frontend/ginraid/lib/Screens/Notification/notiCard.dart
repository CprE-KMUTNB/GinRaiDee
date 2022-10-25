// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
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

class read {
  Client client = http.Client();
  Future<dynamic> delete(int id) async {
    var url =
        Uri.parse('https://ginraid.herokuapp.com/notification-api/${id}/');
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

Container noti(
    BuildContext context,
    int noti_id,
    int id,
    int owner,
    String ownerName,
    String ownerPic,
    bool isFollowing,
    String foodname,
    String foodpic,
    String ingredient,
    String recipes,
    bool isFavorites,
    int favoritesCount,
    DateTime created) {
  String time =
      DateFormat('kk:mm น. dd/MM/yyyy').format(created.add(Duration(hours: 7)));
  return Container(
    margin: EdgeInsets.only(top: 5),
    padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
    height: MediaQuery.of(context).size.height * 0.15,
    width: MediaQuery.of(context).size.width,

    //ไปหน้า Home 2
    child: TapDebouncer(
      onTap: () async {
        var response = await read().delete(noti_id);
        if (response.statusCode == 204) {
          await setReset(true);
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
          );
        }
      }, // your tap handler moved here
      builder: (BuildContext context, TapDebouncerFunc? onTap) {
        return GestureDetector(
          onTap: onTap,
          child: Card(
            color: Color.fromARGB(255, 248, 248, 248),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //รูปโปร
                      Container(
                        // margin: EdgeInsets.only(top: 35),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 226, 226, 226),
                          image: DecorationImage(
                              image: NetworkImage(ownerPic), fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(360)),
                        ),
                      ),

                      //text ต่างๆ
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              ownerName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Text(
                              'ได้เพิ่มเมนูใหม่',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Text(
                              time,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 154, 148, 148),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //รูป
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        width: 90,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(foodpic), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(13),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            elevation: 0,
          ),
        );
      },
    ),
  );
}
