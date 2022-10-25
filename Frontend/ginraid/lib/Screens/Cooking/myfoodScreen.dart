// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/EditFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/foodrequest.dart';
import 'package:ginraid/Screens/Cooking/addFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/myfoodmodel.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/myFood.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class myFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const myFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _myFoodScreenState();
  }
}

class _myFoodScreenState extends State<myFoodScreen> {
  List item = [];
  final searchController = TextEditingController();
  late double screenWidth, screenHeight;

  Timer? timer;

  fetchsearchdata() async {
    var response = await Cooking().search(searchController.text);
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

  fetchdata() async {
    var response = await Cooking().get();
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

  Future<bool> setReset(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('reset', state);
  }

  Future<bool> checkReset() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool reset = await prefs.getBool('reset') ?? false;
    return reset;
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
          'Cooking',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),

      //ปุ่มเพิ่มเมนู
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addFoodScreen()),
          ),
        },
        child: ImageIcon(
          AssetImage('assets/icons/addFood.png'),
          size: 50,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: Color.fromARGB(255, 226, 137, 22),
      ),

      body: Stack(
        children: [
          bgCook1().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Column(
              children: [
                //แถว1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //ชื่อหัวข้อ รายการอาหารของฉัน
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'รายการอาหารของฉัน',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "NotoSansThai",
                              color: Colors.white,
                            ),
                          ),
                        ),

                        //รับค่า จำนวนเมนูอาหารที่อัปโหลดของเจ้าของ
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            '${item.length}',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "NotoSansThai",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // GestureDetector(
                    //   onTap: () => {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const addFoodScreen()),
                    //     ),
                    //   },
                    //   child: Container(
                    //     margin: EdgeInsets.only(right: 15),
                    //     width: 60,
                    //     height: 60,
                    //     decoration: ShapeDecoration(
                    //         color: Color.fromARGB(255, 226, 137, 22),
                    //         shape: CircleBorder()),
                    //     child: ImageIcon(
                    //       AssetImage('assets/icons/addFood.png'),
                    //       size: 50,
                    //       color: Color.fromARGB(255, 255, 255, 255),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                //searchFood แถว 2
                Container(
                  // alignment: Alignment.center,
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

                //กล่องใหญ่
                Container(
                  // color: Colors.amber,
                  margin: EdgeInsets.only(top: 35),
                  height: screenHeight * 0.675,
                  width: screenWidth,
                  child:
                      //กล่องที่ใส่เมนู กล่องใหญ่
                      Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          //เมนูของฉัน
                          getBody(context)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getBody(context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (context, index) {
          return myFood(
              id: Selfmenu.fromJson(item[index]).id!,
              foodname: Selfmenu.fromJson(item[index]).foodname!,
              foodpic: Selfmenu.fromJson(item[index]).foodpic!,
              ingredient: Selfmenu.fromJson(item[index]).ingredient!,
              recipes: Selfmenu.fromJson(item[index]).recipes!,
              isFavorites: Selfmenu.fromJson(item[index]).isFavorites!,
              favoritesCount: Selfmenu.fromJson(item[index]).favoritesCount!,
              isPublic: Selfmenu.fromJson(item[index]).isPublic!);
        });
  }
}
