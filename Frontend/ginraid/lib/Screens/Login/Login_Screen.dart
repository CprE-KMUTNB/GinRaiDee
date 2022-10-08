// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'componants/background.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool _isObscure = true;
  late double screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    @override
    void initState() {
      var _passwordVisible = false;
    }

    return Scaffold(
      backgroundColor: Color(0xFFF1F7E7),
      body: SafeArea(
        child: Stack(
          // child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Mybackground().buildBackground(screenWidth, screenHeight),
            SizedBox(height: 40),

            Container(
              alignment: Alignment.topCenter,
              // width: screenWidth * 0.75,
              child:
                  //กินไรดี
                  Text(
                'กินไรดี \n GinRaiD',
                style: TextStyle(
                  fontSize: 60.0,
                  fontFamily: "Sriracha",
                  color: Color.fromARGB(255, 84, 96, 17),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            // SizedBox(height: 100),
            SingleChildScrollView(
              child:

                  //กล่องใหญ่
                  Container(
                height: 500,
                margin: const EdgeInsets.symmetric(
                    vertical: 200.0, horizontal: 25.0),
                padding: const EdgeInsets.all(47),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(47),
                ),
                child: Column(
                  children: <Widget>[


                    //login/sigin
                    Container(
                      child: Container(
                        child: Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Color.fromARGB(255, 166, 198, 6),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ), 



                    //กรอกusername
                    Container(
                      child: Container(
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 179, 190, 190)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 179, 190, 190),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 50),

                    //กรอกpass
                    Container(
                      child: Container(
                        child: Center(
                          child: TextField(
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 179, 190, 190)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 179, 190, 190),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //fogetpass
                    Container(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Itim",
                              color: Color.fromARGB(255, 179, 190, 190),
                            ),
                          ),
                        ),
                      ),
                    ),

                    

                    //loginbutton
                    Container(
                      child: Container(
                        child: Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Color.fromARGB(255, 166, 198, 6),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
