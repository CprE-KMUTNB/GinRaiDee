// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
                'กินไรดี',
                style: TextStyle(
                  fontFamily: 'Sriracha',
                  fontSize: 50
                )
              ),
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
