import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/EditFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/mycookgotoEditScreen.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';

Container myFood(
  BuildContext context,
  int id,
  String foodname,
  String foodpic,
  String ingredient,
  String recipes,
  bool isFavorites,
  int favoritesCount,
  bool isPublic,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
    height: MediaQuery.of(context).size.height * 0.28,
    width: MediaQuery.of(context).size.width,
    child: Card(
      // color: Colors.amber,
      // ignore: sort_child_properties_last
      child: Column(
        children: [
          //post
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => mycookScreen(
                          id: id,
                          foodname: foodname,
                          foodpic: foodpic,
                          ingredient: ingredient,
                          recipes: recipes,
                          isPublic: isPublic,
                        )),
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
                Icons.delete_sharp,
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
