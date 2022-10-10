import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class loginScreenwid extends StatefulWidget {
  const loginScreenwid({Key? key}) : super(key: key);

  @override
  State<loginScreenwid> createState() => _loginScreenwidState();
  
}

class _loginScreenwidState extends State<loginScreenwid> {
  bool _isObscure = true;
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

// กรอกusername
    return Container(
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 179, 190, 190)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
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
    );

    SizedBox(height: 60);

    //กรอกpass
    Container(
      child: Center(
        child: TextField(
          obscureText: _isObscure,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 179, 190, 190)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
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
    );

    //fogetpass
    Container(
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
    );

    SizedBox(height: 30);

    //loginbutton
    Container(
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
            '   Login   ',
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: "Itim",
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
  }

  
}
Widget getMacroChart() {
      return Center(
        child: Text('macro chart here'),
      );
    }