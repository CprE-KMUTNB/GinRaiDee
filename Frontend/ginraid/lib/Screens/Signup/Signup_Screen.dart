// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Signup/register.dart';
import 'package:ginraid/Screens/Signup/registermodel.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ginraid/Screens/componants/background.dart';
import 'package:ginraid/Screens/componants/AnimatedLog.dart';
import 'package:ginraid/Screens/componants/AnimatedSign.dart';

import 'Signup_Screen.dart';
import '../componants/test.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({Key? key}) : super(key: key);

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  String email_error = "";
  String username_error = "";
  String password_error = "";
  String confirmPassword_error = "";

  bool _isObscure = true;
  bool _isObscure1 = true;
  late double screenWidth, screenHeight;
  int _toggleValue = 0;
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
            Container(
              child:

                  //กล่องใหญ่
                  Container(
                margin:
                    const EdgeInsets.only(top: 225.0, left: 20.0, right: 20.0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(47),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //signup
                      Container(
                        // color: Colors.black26,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'SIGN UP,',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontFamily: "Itim",
                            color: Color.fromARGB(255, 84, 96, 17),
                          ),
                        ),
                      ),

                      //Sign up to get start!
                      Container(
                        // color: Colors.black26,
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Sign up to get start!',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Itim",
                            color: Color.fromARGB(255, 179, 190, 190),
                          ),
                        ),
                      ),

                      // กรอกusername
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: usernameController,
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

                      //email
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 179, 190, 190)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            hintText: 'Email',
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

                      // SizedBox(height: 60),

                      //กรอกpass
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: passwordController,
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

                      //comfirm pass
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: confirmpasswordController,
                          obscureText: _isObscure1,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure1
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
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
                            hintText: 'Confirm Password',
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

                      //confirmbutton
                      Container(
                        //color: Colors.black,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 30),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Color.fromARGB(255, 166, 198, 6),
                          ),
                          onPressed: () async {
                            var user = {
                              "email": emailController.text,
                              "username": usernameController.text,
                              "password": passwordController.text,
                              "confirm_password":
                                  confirmpasswordController.text,
                            };
                            var response =
                                await Register().post('/register/', user);

                            if (response.statusCode == 201) {
                              print('success');
                            } else {
                              email_error = Registermodel.fromJson(
                                              json.decode(response.body))
                                          .email!
                                          .isNotEmpty ==
                                      true
                                  ? Registermodel.fromJson(
                                          json.decode(response.body))
                                      .email![0]
                                  : "";
                              username_error = Registermodel.fromJson(
                                              json.decode(response.body))
                                          .username!
                                          .isNotEmpty ==
                                      true
                                  ? Registermodel.fromJson(
                                          json.decode(response.body))
                                      .username![0]
                                  : "";
                              password_error = Registermodel.fromJson(
                                              json.decode(response.body))
                                          .password!
                                          .isNotEmpty ==
                                      true
                                  ? Registermodel.fromJson(
                                          json.decode(response.body))
                                      .password![0]
                                  : "";
                              confirmPassword_error = Registermodel.fromJson(
                                              json.decode(response.body))
                                          .confirmPassword!
                                          .isNotEmpty ==
                                      true
                                  ? Registermodel.fromJson(
                                          json.decode(response.body))
                                      .confirmPassword![0]
                                  : "";
                              print(email_error);
                              print(username_error);
                              print(password_error);
                              print(confirmPassword_error);
                            }
                          },
                          child: const Text(
                            '       Confirm       ',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Itim",
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      GestureDetector(
                        onTap: () => {Navigator.pop(context)},
                        child: RichText(
                          text: TextSpan(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              TextSpan(
                                text: 'I\’m already a member. ',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Itim",
                                  color: Color.fromARGB(255, 179, 190, 190),
                                ),
                              ),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Itim",
                                  color: Color.fromARGB(255, 166, 198, 6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
