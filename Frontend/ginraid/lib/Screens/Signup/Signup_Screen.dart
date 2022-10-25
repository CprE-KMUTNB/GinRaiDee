// ignore_for_file: prefer_const_constructors, unnecessary_new


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ginraid/Screens/Login/Login_Screen.dart';
import 'package:ginraid/Screens/Signup/register.dart';
import 'package:ginraid/Screens/Signup/registermodel.dart';
import 'package:ginraid/Screens/componants/background.dart';
import 'package:tap_debouncer/tap_debouncer.dart';



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
  String email_error = ""; //////////////////////////////////////////
  String username_error = ""; ////////////////////////////////////////////
  String password_error = ""; /////////////////////////////////////////
  String confirmPassword_error = ""; ///////////////////////////////////
  final _formKey = GlobalKey<FormState>();
  bool singnupsuccess = false;

  bool _isObscure = true;
  bool _isObscure1 = true;
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
        automaticallyImplyLeading: false,
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
            height: screenHeight * 0.64,
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

                    //email
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
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
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
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

                    // กรอกusername
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล';
                          }
                          return null;
                        },
                        controller: usernameController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 179, 190, 190)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
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

                    // SizedBox(height: 60),

                    //กรอกpass
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
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
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
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

                    //comfirm pass
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: confirmpasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล';
                          }
                          if (value != passwordController.text) {
                            return 'รหัสผ่านไม่ตรงกัน';
                          }
                          return null;
                        },
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
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
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

                    //confirmbutton
                    Container(
                      //color: Colors.black,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30),
                      child: TapDebouncer(
                        onTap: () async {
                          var user = {
                            "email": emailController.text,
                            "username": usernameController.text,
                            "password": passwordController.text,
                            "confirm_password": confirmpasswordController.text,
                          };
                          if (_formKey.currentState!.validate()) {
                            var response =
                                await Register().post('/register/', user);

                            if (response.statusCode == 201) {
                              singnupsuccess = true;
                              print('success');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const loginScreen()),
                              );
                            } else {
                              setState(() {
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
                              });
                              if (email_error != '') {
                                showemailError();
                              }
                              if (username_error != '') {
                                showusernameError();
                              }

                              print(email_error);
                              print(username_error);
                              print(password_error);
                              print(confirmPassword_error);
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
                              backgroundColor: Color.fromARGB(255, 166, 198, 6),
                            ),
                            onPressed: onTap,
                            child: const Text(
                              '       Confirm       ',
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

                    SizedBox(height: 20),

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
    );
  }

  void showemailError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Email นี้เคยลงทะเบียนแล้ว",
            style: TextStyle(
                fontSize: 20.0, fontFamily: "Itim", fontWeight: FontWeight.bold
                // color: Color.fromARGB(255, 166, 198, 6),
                ),
          ),
          content: Text(
            'กรุณาเลือกใช้ Email อื่น',
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

  void showusernameError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "username นี้ไม่สามารถใช้งานได้",
            style: TextStyle(
                fontSize: 20.0, fontFamily: "Itim", fontWeight: FontWeight.bold
                // color: Color.fromARGB(255, 166, 198, 6),
                ),
          ),
          content: Text(
            'กรุณาเลือกใช้ username อื่น',
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
