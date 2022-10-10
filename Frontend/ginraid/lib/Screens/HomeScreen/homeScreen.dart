// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:ginraid/Screens/HomeScreen/bgHome1.dart';

class homeScreen extends StatefulWidget {
  static const routeName = '/';

  const homeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _homeScreenState();
  }
}

class _homeScreenState extends State<homeScreen> {
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
          'Home',
          style: TextStyle(
            fontSize: 30.0,
            fontFamily: "Itim",
            color: Colors.white,
          ),
        ),
      ),

      // body: Container(
      //   child:
      //   Container(
      //   height: 180,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage('assets/image/Home1.png'),
      //     ),
      //   ),
      body: Stack(
        children: [
          bgHome1().buildBackground(screenWidth, screenHeight),
          //search
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 110, left: 25, right: 25),
            height: 40,
            child: TextField(
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

          //post
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 180, left: 20, right: 20),
              // color: Colors.amber,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Container(
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 24),
                      // (horizontal: 16.0, vertical: 24.0),
                      height: 600,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(top: 20),
                            color: Colors.blue,
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: Card(
                              color: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 8,
                              child: Container(
                                color: Colors.red,
                                child: Center(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
