// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/services.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome2.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen3.dart';
import 'package:ginraid/Screens/HomeScreen/post.dart';

class homeScreen2 extends StatefulWidget {
  static const routeName = '/';

  const homeScreen2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homeScreen2State();
  }
}

class _homeScreen2State extends State<homeScreen2> {
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
      ),

      
      body: Stack(
        children: [
          bgHome2().buildBackground(screenWidth, screenHeight),
          //กล่องใหญ่ๆ
          Container(
            margin: const EdgeInsets.only(
              top: 210.0,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(60),
            ),
            height: 600,
            width: screenWidth,
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      // color: Colors.amberAccent,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 80, left: 20),
                      child: Text(
                        'ผัดกระเพรา',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: "Sriracha",
                          color: Colors.white,
                        ),
                      ),
                    ),

                    //ไปหน้า user
                    Container(
                      // color: Colors.grey,
                      alignment: Alignment.topLeft,
                      margin:
                          EdgeInsets.only(top: 95, left: screenWidth * 0.25),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const homeScreen3()),
                          ),
                        },
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.account_circle),
                            ),
                            Text(
                              '  User 1',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Itim",
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //รูป
                Container(
                  // color: Colors.amber,
                  height: 180,
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/image/krapow.png',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),

                //ประเภท

                Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
                  child: Row(
                    children: [
                      //ประเภทหัวข้อ
                      Container(
                        child: Text(
                          'ประเภท : ',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "IBMPlexSansThai",
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //ประเภท รับค่า
                      Container(
                        child: Text(
                          'ผัด , กับข้าว',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //วัตถุดิบ
                Container(
                  // color: Colors.indigo,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      //วัตถุดิบ หัวข้อ
                      Container(
                        alignment: Alignment.topLeft,
                        // color: Colors.red,
                        child: Text(
                          'วัตถุดิบ',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "IBMPlexSansThai",
                              color: Color.fromARGB(255, 166, 198, 6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //วัตถุดิบ รับค่า
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          '1.เนื้อไก่ 2 ขีด\n2.น้ำมันพืช 2 ช้อนโต๊ะ\n3.ใบกะเพรา 100 กรัม\n4.ซีอิ้วขาว 1 ช้อนชา\n5.น้ำตาลทราย 1/2 ช้อนชา\n6.พริกชี้ฟ้า 2 เม็ด',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //วิธีทำ
                Container(
                  // color: Colors.indigo,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      //วิธีทำ หัวข้อ
                      Container(
                        alignment: Alignment.topLeft,
                        // color: Colors.red,
                        child: Text(
                          'วิธีทำ',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "IBMPlexSansThai",
                              color: Color.fromARGB(255, 166, 198, 6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //วิธีทำ รับค่า
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          '1.ใส่น้ำมันลงกระทะ\n2.รอน้ำมันร้อนแล้วใส่ไก่ลงไปผัด\n3.ใส่ซีอิ้ว พริก น้ำตาลทรายลงไปผัด\n4.ผัดจนทุกอย่างเข้ากันแล้วใส่ใบกะเพราปิดท้าย\n5.ผัดจนใบกะเพราหดแล้วนำใส่จาน',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "IBMPlexSansThai",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // );
  }
}
