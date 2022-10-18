// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/HomeScreen/homeScreen2.dart';
import 'followingScreen.dart';

class follow extends StatefulWidget {
  static const routeName = '/';

  const follow({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _followState();
  }
}

class _followState extends State<follow> {
  bool isFollowedByMe = true;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 20, right: 20),
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Color.fromARGB(255, 248, 248, 248),
        // ignore: sort_child_properties_last
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //profile pic
                Container(
                  margin: EdgeInsets.only(left: 10, right: 5),
                  child: Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
                ),

                //user name
                Container(
                  child: Text(
                    'User 3',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "Itim",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),

            //ปุ่มฟอล
            Container(
              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      isFollowedByMe = !isFollowedByMe;
                      //ฟอลอยู่           ไม่ฟอล อัลฟอล
                    },
                  );
                },
                child: AnimatedContainer(
                  height: 35,
                  width: 110,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isFollowedByMe
                        ? Colors.transparent
                        : Color.fromARGB(255, 224, 132, 106),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isFollowedByMe
                          ? Color.fromARGB(255, 224, 132, 106)
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      isFollowedByMe ? 'Following' : 'Follow',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: "IBMPlexSansThaiReg",
                        color: isFollowedByMe
                            ? Color.fromARGB(255, 224, 132, 106)
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        elevation: 0,
      ),
    );
  }
}
