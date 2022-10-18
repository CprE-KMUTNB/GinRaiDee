// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/services.dart';
import 'package:ginraid/Screens/FavoriteScreen/bgFav1.dart';
import 'package:ginraid/Screens/FavoriteScreen/bgFav2.dart';
import 'package:ginraid/Screens/FavoriteScreen/bgFav3.dart';
import 'package:ginraid/Screens/FavoriteScreen/postfav.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';

class favFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const favFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _favFoodScreenState();
  }
}

class _favFoodScreenState extends State<favFoodScreen> {
  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'รายการอาหารที่ชอบ',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          bgfav3().buildBackground(screenWidth, screenHeight),

          // //search
          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.only(top: 90, left: 20, right: 20),
          //   child: Column(
          //     children: [
          //       Container(
          //         //แถวแรก
          //         child: Row(
          //           children: [
          //             //profile pic
          //             Icon(
          //               Icons.account_circle,
          //               size: 60,
          //             ),

          //             //ข้อมูลชื่อไฟล์
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 //name profile
          //                 Container(
          //                   margin: EdgeInsets.only(left: 20),
          //                   child: Text(
          //                     'My User',
          //                     style: TextStyle(
          //                       fontSize: 30.0,
          //                       fontFamily: "Itim",
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),

          //                 //edit profile button
          //                 Container(
          //                   alignment: Alignment.center,
          //                   margin: EdgeInsets.only(top: 5, left: 22),
          //                   height: 30,
          //                   child: TextButton(
          //                     style: TextButton.styleFrom(
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(30),
          //                       ),
          //                       backgroundColor:
          //                           Color.fromARGB(255, 255, 255, 255),
          //                     ),
          //                     onPressed: () {},
          //                     child: const Text(
          //                       ' Edit Profile ',
          //                       style: TextStyle(
          //                         fontSize: 15.0,
          //                         fontFamily: "Itim",
          //                         color: Color.fromARGB(255, 0, 0, 0),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),

          //       //แถว2
          //       Container(
          //         margin: EdgeInsets.only(top: 10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             //จำนวน กำลังติดตาม
          //             Container(
          //               width: screenWidth * 0.5,
          //               child: Text(
          //                 '2',
          //                 style: TextStyle(
          //                   fontSize: 20.0,
          //                   fontFamily: "Itim",
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),

          //             //จำนวน อาหารที่ชอบ
          //             Container(
          //               child: Text(
          //                 '4',
          //                 style: TextStyle(
          //                   fontSize: 20.0,
          //                   fontFamily: "Itim",
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),

          //       //แถว 3
          //       Container(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             //ปุ่มกำลังติดตาม
          //             Container(
          //               margin: EdgeInsets.only(top: 5),
          //               height: 39,
          //               width: 130,
          //               child: TextButton(
          //                 style: TextButton.styleFrom(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(13),
          //                   ),
          //                   backgroundColor: Color.fromARGB(255, 251, 147, 117),
          //                 ),
          //                 onPressed: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => const fav2Screen(),),
          //                   );
          //                 },
          //                 child: const Text(
          //                   ' กำลังติดตาม ',
          //                   style: TextStyle(
          //                     fontSize: 20.0,
          //                     fontFamily: "IBMPlexSansThai",
          //                     color: Color.fromARGB(255, 255, 255, 255),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(
          //               width: screenWidth * 0.15,
          //             ),

          //             //ปุ่มรายการอาหารที่ชอบ
          //             Container(
          //               margin: EdgeInsets.only(top: 5),
          //               height: 39,
          //               width: 130,
          //               child: TextButton(
          //                 style: TextButton.styleFrom(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(13),
          //                   ),
          //                   backgroundColor: Color.fromARGB(255, 251, 147, 117),
          //                 ),
          //                 onPressed: () {},
          //                 child: const Text(
          //                   ' อาหารที่ชอบ ',
          //                   style: TextStyle(
          //                     fontSize: 20.0,
          //                     fontFamily: "IBMPlexSansThai",
          //                     color: Color.fromARGB(255, 255, 255, 255),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),

          //       //แถวที่ 4

          //       Container(
          //         margin: EdgeInsets.only(top: 35),
          //         child: Row(
          //           // ignore: prefer_const_literals_to_create_immutables
          //           children: [
          //             Text(
          //               'My favorites ',
          //               style: TextStyle(
          //                 fontSize: 25.0,
          //                 fontFamily: "Itim",
          //                 color: Color.fromARGB(255, 0, 0, 0),
          //               ),
          //             ),
          //             Text(
          //               '4',
          //               style: TextStyle(
          //                 fontSize: 25.0,
          //                 fontFamily: "Itim",
          //                 color: Color.fromARGB(255, 0, 0, 0),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),

          //       //post
          //       Container(
          //         // color: Colors.amber,
          //         // margin: EdgeInsets.only(left: 15, right: 15),
          //         height: 470,
          //         width: screenWidth,
          //         // color: Colors.blueAccent,
          //         child: SingleChildScrollView(
          //           child: Column(
          //             children: <Widget>[
          //               //1post
          //               postFav(context),
          //               postFav(context),
          //               postFav(context),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
