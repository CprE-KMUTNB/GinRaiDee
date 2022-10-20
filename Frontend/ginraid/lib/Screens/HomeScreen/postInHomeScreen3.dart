// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';

Container Userpost(
    BuildContext context,
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
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
    height: MediaQuery.of(context).size.height * 0.27,
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
