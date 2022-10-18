// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook2.dart';

class addFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const addFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _addFoodScreenState();
  }
}

class _addFoodScreenState extends State<addFoodScreen> {
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
          'Add Cooking',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          bgCook2().buildBackground(screenWidth, screenHeight),
          // Container(
          //   margin: EdgeInsets.only(top: 75),
          //   child: Column(
          //     children: [
          //       //แถว1
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           //ชื่อหัวข้อ รายการอาหารของฉัน
          //           Row(
          //             children: [
          //               Container(
          //                 margin: EdgeInsets.only(left: 20),
          //                 child: Text(
          //                   'รายการอาหารของฉัน',
          //                   style: TextStyle(
          //                     fontSize: 25.0,
          //                     fontFamily: "NotoSansThai",
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),

          //               //รับค่า จำนวนเมนูอาหารที่อัปโหลดของเจ้าของ
          //               Container(
          //                 margin: EdgeInsets.only(left: 20),
          //                 child: Text(
          //                   '4',
          //                   style: TextStyle(
          //                     fontSize: 25.0,
          //                     fontFamily: "NotoSansThai",
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),


          //           GestureDetector(
          //               onTap: () => {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => const signupScreen()),
          //                 ),
          //               },
          //           child: Container(
          //             margin: EdgeInsets.only(right: 15),
          //             width: 60,
          //             height: 60,
          //             decoration: ShapeDecoration(
          //                 color: Color.fromARGB(255, 226, 137, 22),
          //                 shape: CircleBorder()),
          //             child: ImageIcon(
          //               AssetImage('assets/icons/addFood.png'),
          //               size: 50,
          //               color: Color.fromARGB(255, 255, 255, 255),
          //             ),
          //           ),
          //       ),],
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
