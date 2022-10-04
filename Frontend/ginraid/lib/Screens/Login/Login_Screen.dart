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
                style: GoogleFonts.itim(fontStyle: FontStyle.italic,fontSize: 50),
                // TextStyle(
                //   fontSize: 50,
                //   fontFamily: 'Sriracha',
                //   color: Colors.teal
                )
              ,
              SizedBox(height : 20),


              //login/sigin

              //email

              //pass

              //login
              ]
          ),
        ),
      ),
    );
  }
}
