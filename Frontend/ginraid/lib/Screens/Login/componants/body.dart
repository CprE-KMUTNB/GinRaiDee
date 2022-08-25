import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[Positioned(
          top: 0,
          child: Image.asset("Frontend/ginraid/assets/image/loginbacktrans.jpg",width: size.width * 0.3,))],),
    // ignore: dead_code
    );
    
  }
}