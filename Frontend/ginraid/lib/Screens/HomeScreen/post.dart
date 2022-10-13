// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';

Container post(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
    height: MediaQuery.of(context).size.height * 0.35,
    width: MediaQuery.of(context).size.width,
    child: Card(
      // color: Colors.amber,
      // ignore: sort_child_properties_last
      child: Column(
        children: [
          Row(
            children: [
              //รูปโปร
              Container(
                child: Icon(
                  Icons.account_circle,
                  size: 45.0,
                ),
              ),
              //ชื่อ
              Container(
                child: Text(
                  '  User 1',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Itim",
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 100.0),

              //followbut
              Container(
                // color: Colors.black,
                // alignment: Alignment.topRight,
                // // margin: EdgeInsets.only(top: 30),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Color.fromARGB(255, 237, 237, 237),
                  ),
                  onPressed: () {},
                  child: const Text(
                    '    Follow    ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Itim",
                      color: Color.fromARGB(255, 235, 31, 31),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //namemenu
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const homeScreen2()),
              ),
            },

            // child: Container(
            //   child: Container(
            //   alignment: Alignment.topLeft,
            //   margin: EdgeInsets.only(left: 25, top: 5),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25, top: 5),
                  child: Text(
                    'ผัดกระเพรา',
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
                        image: AssetImage(
                          'assets/image/krapow.png',
                        ),
                        fit: BoxFit.cover),
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
