// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/services.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome2.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome3.dart';
import 'package:ginraid/Screens/HomeScreen/homescreenrequest.dart';
import 'package:ginraid/Screens/HomeScreen/menu_data.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';
import 'package:ginraid/Screens/HomeScreen/postInHomeScreen3.dart';
import 'package:ginraid/Screens/HomeScreen/reportUserScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import 'homeScreen2.dart';

class homeScreen3 extends StatefulWidget {
  static const routeName = '/';
  int owner;
  String ownerName;
  String ownerPic;
  bool? isFollowing;
  homeScreen3(
      {required this.owner,
      required this.ownerName,
      required this.ownerPic,
      this.isFollowing});

  @override
  State<StatefulWidget> createState() {
    return _homeScreen3State(
        owner: owner,
        ownerName: ownerName,
        ownerPic: ownerPic,
        isFollowing: isFollowing);
  }
}

const String baseUrl = 'https://ginraid.herokuapp.com/user-api/';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

class _homeScreen3State extends State<homeScreen3> {
  int owner;
  String ownerName;
  String ownerPic;
  bool? isFollowing;
  _homeScreen3State(
      {required this.owner,
      required this.ownerName,
      required this.ownerPic,
      this.isFollowing});

  List item = [];
  int follower = 0;
  bool isfollowing = false;

  fetchdata() async {
    var response = await Userviewmenu().get(owner);

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        item = data["menu"];
        follower = data["follower_count"];
        isfollowing = data["is_follow"];
      });
    } else {
      setState(() {
        item = [];
      });
    }
  }

  isreset() async {
    if (await checkReset() == true) {
      await setReset(false);
    }
  }

  Timer? timer;

  Future<bool> setReset(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('reset', state);
  }

  Future<bool> checkReset() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool reset = await prefs.getBool('reset') ?? false;
    return reset;
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) => isreset());
    fetchdata();
    getid();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool showbutton = false;
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

  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (!showbutton) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            bgHome3().buildBackground(screenWidth, screenHeight),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 80, left: 10, right: 10),
              child: Column(
                children: [
                  //แถวแรก
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Align(
                      //   alignment: Alignment.center,
                      // ),
                      //name user icon
                      Row(
                        children: [
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

                          //name user
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              ownerName,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Itim",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //follow buttom
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       // margin: EdgeInsets.only(right: 5),
                      //       alignment: Alignment.center,
                      //       child: GestureDetector(
                      //         onTap: () async {
                      //           if (isFollowing == false) {
                      //             var followid = {"following": owner};
                      //             var response = await follow().post(followid);
                      //             if (response.statusCode == 201) {
                      //               print('follow');
                      //               await setReset(true);
                      //               setState(
                      //                 () {
                      //                   follower += 1;
                      //                   isFollowing = !(isFollowing == null
                      //                       ? isfollowing
                      //                       : isFollowing!);
                      //                   //ฟอลอยู่           ไม่ฟอล อัลฟอล
                      //                 },
                      //               );
                      //             } else {
                      //               print('server down');
                      //             }
                      //           } else {
                      //             var response = await follow().delete(owner);
                      //             if (response.statusCode == 204) {
                      //               await setReset(true);
                      //               print('unfollow');
                      //               setState(
                      //                 () {
                      //                   follower -= 1;
                      //                   isFollowing = !(isFollowing == null
                      //                       ? isfollowing
                      //                       : isFollowing!);
                      //                   //ฟอลอยู่           ไม่ฟอล อัลฟอล
                      //                 },
                      //               );
                      //             } else {
                      //               print('server down');
                      //             }
                      //           }
                      //         },
                      //         child: AnimatedContainer(
                      //           height: 35,
                      //           width: 110,
                      //           duration: Duration(milliseconds: 300),
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(30),
                      //           ),
                      //           child: Center(
                      //             child: Text(
                      //               (isFollowing == null
                      //                       ? isfollowing
                      //                       : isFollowing!)
                      //                   ? 'Following'
                      //                   : 'Follow',
                      //               style: TextStyle(
                      //                 fontSize: 17.0,
                      //                 fontFamily: "IBMPlexSansThaiReg",
                      //                 color: (isFollowing == null
                      //                         ? isfollowing
                      //                         : isFollowing!)
                      //                     ? Color.fromARGB(255, 166, 198, 6)
                      //                     : Color.fromARGB(255, 251, 0, 0),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),

                      //     //report buttom
                      //     Container(
                      //       margin: EdgeInsets.only(left: 2),
                      //       child: IconButton(
                      //         icon: Icon(
                      //           Icons.report,
                      //           size: 30.0,
                      //         ),
                      //         onPressed: () {
                      //           setState(
                      //             () {
                      //               Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         reportUserScreen()),
                      //               );
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),

                  //แถวที่2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //text ผู้ติดตาม
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'ผู้ติดตาม ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //จำนวนผู้ติดตาม
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          '$follower ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //หน่วย
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'คน',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //text เมนูอาหาร
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 10),
                        child: Text(
                          'เมนูอาหาร ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //จำนวน เมนูอาหาร
                      Container(
                        margin: EdgeInsets.only(
                          top: 30,
                        ),
                        child: Text(
                          '${item.length} ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //หน่วย เมนูอาหาร
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'รายการ ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  Container(
                    // color: Colors.amber,
                    // margin: EdgeInsets.only(left: 15, right: 15),
                    height: 560,
                    width: screenWidth,
                    // color: Colors.blueAccent,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        //1post
                        getBody(context)
                      ]

                          //post

                          ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            bgHome3().buildBackground(screenWidth, screenHeight),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 80, left: 10, right: 10),
              child: Column(
                children: [
                  //แถวแรก
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Align(
                      //   alignment: Alignment.center,
                      // ),
                      //name user icon
                      Row(
                        children: [
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

                          //name user
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              ownerName,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Itim",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //follow buttom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            child: TapDebouncer(
                              onTap: () async {
                                if (isFollowing == false) {
                                  var followid = {"following": owner};
                                  var response = await follow().post(followid);
                                  if (response.statusCode == 201) {
                                    print('follow');
                                    await setReset(true);
                                    setState(
                                      () {
                                        follower += 1;
                                        isFollowing = !(isFollowing == null
                                            ? isfollowing
                                            : isFollowing!);
                                        //ฟอลอยู่           ไม่ฟอล อัลฟอล
                                      },
                                    );
                                  } else {
                                    print('server down');
                                  }
                                } else {
                                  var response = await follow().delete(owner);
                                  if (response.statusCode == 204) {
                                    await setReset(true);
                                    print('unfollow');
                                    setState(
                                      () {
                                        follower -= 1;
                                        isFollowing = !(isFollowing == null
                                            ? isfollowing
                                            : isFollowing!);
                                        //ฟอลอยู่           ไม่ฟอล อัลฟอล
                                      },
                                    );
                                  } else {
                                    print('server down');
                                  }
                                }
                              }, // your tap handler moved here
                              builder: (BuildContext context,
                                  TapDebouncerFunc? onTap) {
                                return GestureDetector(
                                  onTap: onTap,
                                  child: AnimatedContainer(
                                    height: 35,
                                    width: 110,
                                    duration: Duration(milliseconds: 300),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        (isFollowing == null
                                                ? isfollowing
                                                : isFollowing!)
                                            ? 'Following'
                                            : 'Follow',
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: "IBMPlexSansThaiReg",
                                          color: (isFollowing == null
                                                  ? isfollowing
                                                  : isFollowing!)
                                              ? Color.fromARGB(255, 166, 198, 6)
                                              : Color.fromARGB(255, 251, 0, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          //report buttom
                          // Container(
                          //   margin: EdgeInsets.only(left: 2),
                          //   child: IconButton(
                          //     icon: Icon(
                          //       Icons.report,
                          //       size: 30.0,
                          //     ),
                          //     onPressed: () {
                          //       setState(
                          //         () {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     reportUserScreen()),
                          //           );
                          //         },
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),

                  //แถวที่2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //text ผู้ติดตาม
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'ผู้ติดตาม ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //จำนวนผู้ติดตาม
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          '$follower ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //หน่วย
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'คน',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //text เมนูอาหาร
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 10),
                        child: Text(
                          'เมนูอาหาร ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //จำนวน เมนูอาหาร
                      Container(
                        margin: EdgeInsets.only(
                          top: 30,
                        ),
                        child: Text(
                          '${item.length} ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),

                      //หน่วย เมนูอาหาร
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          'รายการ ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  Container(
                    // color: Colors.amber,
                    // margin: EdgeInsets.only(left: 15, right: 15),
                    height: 560,
                    width: screenWidth,
                    // color: Colors.blueAccent,
                    child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        //1post
                        getBody(context)
                      ]

                          //post

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
  }

  Widget getBody(context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.length,
        itemBuilder: (context, index) {
          return Userpost(
              id: MenuAll.fromJson(item[index]).id,
              owner: MenuAll.fromJson(item[index]).owner,
              ownerName: MenuAll.fromJson(item[index]).ownerName,
              ownerPic: MenuAll.fromJson(item[index]).ownerPic,
              isFollowing: MenuAll.fromJson(item[index]).isFollowing,
              foodname: MenuAll.fromJson(item[index]).foodname,
              foodpic: MenuAll.fromJson(item[index]).foodpic,
              ingredient: MenuAll.fromJson(item[index]).ingredient,
              recipes: MenuAll.fromJson(item[index]).recipes,
              isFavorites: MenuAll.fromJson(item[index]).isFavorites,
              favoritesCount: MenuAll.fromJson(item[index]).favoritesCount,
              created: MenuAll.fromJson(item[index]).created);
        });
  }
}
