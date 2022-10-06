// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';

class loginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var imageStrings = ['Frontend\ginraid\assets\image\loginbacktrans.png'];

    return Scaffold(
        backgroundColor: Color(0xFFF1F7E7),
        body: SafeArea(
          child: Center(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                //กินไรดี
                Text(
                  'กินไรดีGinrai de',
                  style: GoogleFonts.sriracha(
                      fontSize: 50.0, fontStyle: FontStyle.italic),
                  // style: TextStyle(
                  //   fontSize: 50.0,
                  //   fontFamily: "Sriracha",
                  //   color: Colors.teal
                  // ),
                ),
                SizedBox(height: 40),

                //กล่องใหญ่
                Container(
                  height: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(16)),

                  //กรอกusername
                  child: 
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: 
                    TextField(
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
                        hintStyle: GoogleFonts.itim(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelStyle: GoogleFonts.itim(
                          fontSize: 30.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                //   new Row(

                //   //กรอกpass
                //     child: Padding(
                //     padding: const EdgeInsets.only(left: 20.0),
                //     child: TextField(
                //       obscureText: true,
                //       decoration: InputDecoration(
                //         icon: Icon(Icons.visibility),
                //         suffixIcon: Icon(Icons.remove_red_eye),
                //         enabledBorder: UnderlineInputBorder(
                //           borderSide: BorderSide(
                //               color: Color.fromARGB(255, 179, 190, 190)),
                //         ),
                //         focusedBorder: UnderlineInputBorder(
                //           borderSide:
                //               BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                //         ),
                //         hintText: 'Password',
                //         hintStyle: GoogleFonts.itim(
                //           fontSize: 20.0,
                //           color: Color.fromARGB(255, 179, 190, 190),
                //         ),
                //         labelStyle: GoogleFonts.itim(
                //           fontSize: 30.0,
                //           color: Color.fromARGB(255, 0, 0, 0),
                //         ),
                //       ),
                //     ),
                //   ),
                //   )
                // )

                //login/sigin

                //email
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal:25.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color:
                //     ),
                //     child: TextField(
                //       decoration : InputDecoration(
                //         border: InputBorder.none,
                //       )
                //     ),
                //   ),
                // )

                //login
              ],
            ),
          ),
        ));
  }
}
