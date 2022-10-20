// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';

Container noti(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
    height: MediaQuery.of(context).size.height * 0.15,
    width: MediaQuery.of(context).size.width,

    //ไปหน้า Home 2
    child: GestureDetector(
      // onTap: () => {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const homeScreen2()),
      //   ),
      // },
      child: Card(
        color: Color.fromARGB(255, 248, 248, 248),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //รูปโปร
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    // alignment: Alignment.center,
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
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
                          'User 1',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Itim",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          'ได้เพิ่มเมนูอาหารใหม่',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Itim",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          'เมื่อ 5 นาทีที่แล้ว',
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
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: 90,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/image/krapow.png',
                          ),
                          fit: BoxFit.cover),
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
    ),
  );
}
