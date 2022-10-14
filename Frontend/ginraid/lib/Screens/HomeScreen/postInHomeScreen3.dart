// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';

Container Userpost(BuildContext context) {
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
                MaterialPageRoute(builder: (context) => const homeScreen2()),
              ),
            },
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  // margin: EdgeInsets.only(top: 20),
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
                  alignment: Alignment.center,
                  // margin: EdgeInsets.only(top: 35),
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
