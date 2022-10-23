// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Favorite/favoriterequest.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';
import 'package:ginraid/Screens/HomeScreen/reportPostScreen.dart';

class Userpost extends StatefulWidget {
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
  Userpost({
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
  _UserpostState createState() => _UserpostState(
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

class _UserpostState extends State<Userpost> {
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
  _UserpostState({
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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool isFollowedByMe = true;
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      height: MediaQuery.of(context).size.height * 0.29,
      width: MediaQuery.of(context).size.width,
      child: Card(
        // color: Colors.amber,
        // ignore: sort_child_properties_last
        child: Column(
          children: [
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    // margin: EdgeInsets.only(top: 20),
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
                    alignment: Alignment.center,
                    // margin: EdgeInsets.only(top: 35),
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
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: isFavorites
                            ? Color.fromARGB(255, 166, 198, 6)
                            : Colors.black,
                      ),
                      onPressed: () async {
                        if (isFavorites == false) {
                          var response = await Favoritefood().post(id);
                          if (response.statusCode == 201) {
                            print('favorite');
                            await setReset(true);
                            setState(
                              () {
                                isFavorites = !isFavorites;
                                favoritesCount += 1;
                                //ฟอลอยู่           ไม่ฟอล อัลฟอล
                              },
                            );
                          } else {
                            print('server down');
                          }
                        } else {
                          var response = await Favoritefood().delete(id);
                          if (response.statusCode == 204) {
                            print('unfavorite');
                            await setReset(true);
                            setState(
                              () {
                                isFavorites = !isFavorites;
                                favoritesCount -= 1;
                                //ฟอลอยู่           ไม่ฟอล อัลฟอล
                              },
                            );
                          } else {
                            print('server down');
                          }
                        }
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
                                builder: (context) => reportPostScreen()),
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
