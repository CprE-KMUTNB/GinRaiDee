import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/mycookgotoEditScreen.dart';
import 'package:ginraid/Screens/Favorite/favoriterequest.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class myFood extends StatefulWidget {
  static const routeName = '/';

  int id;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isFavorites;
  int favoritesCount;
  bool isPublic;

  myFood({
    required this.id,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isFavorites,
    required this.favoritesCount,
    required this.isPublic,
  });

  @override
  _myFoodState createState() => _myFoodState(
      id: id,
      foodname: foodname,
      foodpic: foodpic,
      ingredient: ingredient,
      recipes: recipes,
      isFavorites: isFavorites,
      favoritesCount: favoritesCount,
      isPublic: isPublic);
}

class _myFoodState extends State<myFood> {
  int id;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isFavorites;
  int favoritesCount;
  bool isPublic;
  _myFoodState({
    required this.id,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isFavorites,
    required this.favoritesCount,
    required this.isPublic,
  });

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueAccent,
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      height: 258,
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
                  //ชื่อเมนู
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
            
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(width: 15),
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
                  }, // your tap handler moved here
                  builder: (BuildContext context, TapDebouncerFunc? onTap) {
                    return IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: isFavorites
                            ? Color.fromARGB(255, 224, 132, 106)
                            : Colors.black,
                      ),
                      onPressed: onTap,
                    );
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
            )
          ],
        ),

        elevation: 0,
      ),
    );
  }
}
