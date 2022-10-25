// ignore_for_file: prefer_const_constructors, unnecessary_new



import 'package:flutter/material.dart';

import 'package:ginraid/Screens/Login/login.dart';
import 'package:ginraid/Screens/Login/loginmodel.dart';
import 'package:ginraid/Screens/componants/homeinhome.dart';


import 'package:ginraid/Screens/componants/background.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import '../Signup/Signup_Screen.dart';


import 'dart:convert';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

Future<dynamic> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', value);
}

Future<dynamic> setUserID(int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt('user_id', value);
}

Future<dynamic> setUsername(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('username', value);
}

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String token = await prefs.getString('token').toString();
  return token;
}

Future<String> getUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String username = await prefs.getString('username').toString();
  return username;
}

Future<int> getID() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int userID = await prefs.getInt('user_id')!;
  return userID;
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email_error = ""; /////////////////////////////////////////////
  String password_error = ""; /////////////////////////////////////////
  String error = ""; ///////////////////////////////////////////////////
  bool islogin = false;

  bool _isObscure = true;
  late double screenWidth, screenHeight;
  int _toggleValue = 0;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    @override
    void initState() {
      var _passwordVisible = false;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF1F7E7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Mybackground().buildBackground(screenWidth, screenHeight),

          Container(
            margin: EdgeInsets.only(top: 30),
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

          //กล่องใหญ่
          Container(
            height: screenHeight * 0.6,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 240),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(47),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //login
                    Container(
                      // color: Colors.black26,
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        'LOGIN,',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontFamily: "Itim",
                          color: Color.fromARGB(255, 84, 96, 17),
                        ),
                      ),
                    ),

                    //sign in to continue!
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text(
                        'Sign in to continue!',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Itim",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                      ),
                    ),

                    // กรอกemail
                    Container(
                      child: Center(
                        child: TextFormField(
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: 'กรุณากรอกข้อมูล'),
                              EmailValidator(errorText: 'กรุณากรอก Email'),
                            ],
                          ),
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
                            errorStyle: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Itim",
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 60),

                    //กรอกpass
                    Container(
                      child: Center(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
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
                            errorStyle: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Itim",
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //fogetpass
                    Container(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: TextButton.styleFrom(),
                        onPressed: () {},
                        child: const Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Itim",
                            color: Color.fromARGB(255, 179, 190, 190),
                          ),
                        ),
                      ),
                    ),

                    // SizedBox(height: 30),

                    //loginbutton
                    Container(
                      child: Center(
                        child: TapDebouncer(
                          onTap: () async {
                            var user = {
                              "username": emailController.text,
                              "password": passwordController.text,
                            };
                            if (_formKey.currentState!.validate()) {
                              var response =
                                  await Login().post('/login/', user);

                              if (response.statusCode == 200) {
                                int userid = Loginmodel.fromJson(
                                        json.decode(response.body))
                                    .userId!;
                                String username = Loginmodel.fromJson(
                                        json.decode(response.body))
                                    .name!;
                                String token = Loginmodel.fromJson(
                                        json.decode(response.body))
                                    .token!;
                                setToken(token);
                                setUserID(userid);
                                setUsername(username);
                                print(await getID());
                                print(await getUsername());
                                print(await getToken());
                                print('success');
                                islogin = true;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const homeinScreen()),
                                );
                              } else {
                                setState(
                                  () {
                                    showError();
                                    email_error = Loginmodel.fromJson(
                                                    json.decode(response.body))
                                                .email!
                                                .isNotEmpty ==
                                            true
                                        ? Loginmodel.fromJson(
                                                json.decode(response.body))
                                            .email![0]
                                        : "";
                                    password_error = Loginmodel.fromJson(
                                                    json.decode(response.body))
                                                .password!
                                                .isNotEmpty ==
                                            true
                                        ? Loginmodel.fromJson(
                                                json.decode(response.body))
                                            .password![0]
                                        : "";

                                    error = Loginmodel.fromJson(
                                                    json.decode(response.body))
                                                .error!
                                                .isNotEmpty ==
                                            true
                                        ? Loginmodel.fromJson(
                                                json.decode(response.body))
                                            .error![0]
                                        : "";
                                  },
                                );

                                print(email_error);
                                print(password_error);
                                print(error);
                              }
                            }
                          }, // your tap handler moved here
                          builder:
                              (BuildContext context, TapDebouncerFunc? onTap) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 166, 198, 6),
                              ),
                              onPressed: onTap,
                              child: const Text(
                                '       Login       ',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "Itim",
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const signupScreen()),
                        ),
                      },
                      child: RichText(
                        text: TextSpan(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            TextSpan(
                              text: 'I\’m new user. ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Itim",
                                color: Color.fromARGB(255, 179, 190, 190),
                              ),
                            ),
                            TextSpan(
                              text: 'Sign Up',
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
    );
  }

  void showError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "ไม่พบข้อมูล",
            style: TextStyle(
                fontSize: 20.0, fontFamily: "Itim", fontWeight: FontWeight.bold
                // color: Color.fromARGB(255, 166, 198, 6),
                ),
          ),
          content: Text(
            'กรุณาตรวจสอบ Email หรือ รหัสผ่านใหม่อีกครั้ง',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Itim",
              // color: Color.fromARGB(255, 166, 198, 6),
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: const Text(
                "ตกลง",
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Itim",
                  color: Color.fromARGB(255, 166, 198, 6),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
