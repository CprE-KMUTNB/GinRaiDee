// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook2.dart';
import 'package:image_picker/image_picker.dart';

class addFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const addFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _addFoodScreenState();
  }
}

class _addFoodScreenState extends State<addFoodScreen> {
  late double screenWidth, screenHeight;
  File? imageFile;

  String? _retrieveDataError;

  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  // String selectedValue = "สาธารณะ";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            'สาธารณะ',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "NotoSansThai",
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          //เปลี่ยนค่าตรงนี้
          value: "สาธารณะ"),
      DropdownMenuItem(
          child: Text(
            'ส่วนตัว',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "NotoSansThai",
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          value: "ส่วนตัว"),
    ];
    return menuItems;
  }

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
      ),
      body: Stack(
        children: [
          bgCook2().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(top: 75),
            child: Row(
              //แถว1
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //ชื่อหัวข้อ เพิ่มเมนูอาหาร
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'เพิ่มเมนูอาหาร',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "NotoSansThai",
                      color: Colors.white,
                    ),
                  ),
                ),

                Container(
                  child: ImageIcon(
                    AssetImage('assets/icons/addFood.png'),
                    size: 50,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),

          //กล่องใหญ่
          Container(
            height: screenHeight * 0.76,
            margin: const EdgeInsets.only(top: 140),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(47),
                topLeft: Radius.circular(47),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //กรอกชื่อเมนู
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextField(
                      // maxLines: null,
                      textAlignVertical: TextAlignVertical.bottom,
                      // controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 179, 190, 190)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        hintText: 'ชื่อเมนู',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelText: 'ชื่อเมนู',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            iconSize: 35,
                            icon: Icon(Icons.image_outlined),
                            onPressed: () =>
                                getImage(source: ImageSource.gallery),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            iconSize: 35,
                            icon: Icon(Icons.camera_alt_rounded),
                            onPressed: () =>
                                getImage(source: ImageSource.camera),
                          ),
                        )
                      ],
                    ),
                  ),

                  if (imageFile != null)
                    Container(
                      height: 180,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        image: DecorationImage(
                          image: FileImage(imageFile!),
                        ),
                      ),
                    ),

                  if (imageFile == null)
                    Container(
                      height: 180,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),

                  //วัตถุดิบ
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.bottom,
                      // controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 179, 190, 190)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        hintText: 'วัตถุดิบ',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelText: 'วัตถุดิบ',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                      ),
                    ),
                  ),

                  //วิธีทำ
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextField(
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.bottom,
                      // controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 179, 190, 190)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        hintText: 'วิธีทำ',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                        labelText: 'วิธีทำ',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 179, 190, 190),
                        ),
                      ),
                    ),
                  ),

                  //เลือกความเป็นส่วนตัว
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Form(
                      key: _dropdownFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 179, 190, 190)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                                hintText: 'ความเป็นส่วนตัว',
                                hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "NotoSansThai",
                                  color: Color.fromARGB(255, 179, 190, 190),
                                ),
                                labelText: 'ความเป็นส่วนตัว',
                                labelStyle: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "NotoSansThai",
                                  color: Color.fromARGB(255, 179, 190, 190),
                                ),
                              ),
                              validator: (value) =>
                                  value == null ? "ความเป็นส่วนตัว" : null,
                              dropdownColor: Color.fromARGB(255, 255, 255, 255),
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    selectedValue = newValue!;
                                  },
                                );
                              },
                              items: dropdownItems),
                        ],
                      ),
                    ),
                  ),

                  //ปุ่มยืนยัน
                  Container(
                    width: 120,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Color.fromARGB(255, 246, 170, 72),
                      ),
                      onPressed: () async {},
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),

                  // else
                  //   Container(
                  //       color: Colors.black26,
                  //     decoration: BoxDecoration(image: DecorationImage(image: FileImage(imageFile!),),),)

                  // Container(
                  //   color: Colors.blue,
                  //   height: 1000,
                  //   child: Text(
                  //     'เพิ่มเมนูอาหาร',
                  //     style: TextStyle(
                  //       fontSize: 25.0,
                  //       fontFamily: "NotoSansThai",
                  //       color: Color.fromARGB(255, 144, 98, 98),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
