// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook2.dart';
import 'package:ginraid/Screens/Cooking/foodrequest.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class addFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const addFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _addFoodScreenState();
  }
}

class _addFoodScreenState extends State<addFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  late double screenWidth, screenHeight;
  File? imageFile;

  String? _retrieveDataError;

  String? selectedValue = null;

  String error = ''; ////////////////////////////////////
  final _dropdownFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ingredientController = TextEditingController();
  final recipeController = TextEditingController();

  bool isPublic = true;

  Future<bool> setReset(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('reset', state);
  }

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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    String privacy = isPublic ? "สาธารณะ" : "ส่วนตัว";

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
            height: screenHeight * 0.85,
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    //กรอกชื่อเมนู
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล';
                          }
                          return null;
                        },
                        controller: nameController,
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
                          errorStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
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
                        child: Text(
                          'กรุณาใส่รูปภาพ',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        // height: 180,
                        // width: screenWidth,
                        // decoration: BoxDecoration(
                        //   color: Color.fromARGB(255, 255, 255, 255),
                        // ),
                      ),

                    //วัตถุดิบ
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล';
                          }
                          return null;
                        },
                        controller: ingredientController,
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
                          errorStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                      ),
                    ),

                    //วิธีทำ
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกข้อมูล';
                          }
                          return null;
                        },
                        controller: recipeController,
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
                          errorStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: "NotoSansThai",
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0)),
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
                                dropdownColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                value: privacy,
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      isPublic = !isPublic;
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
                      child: TapDebouncer(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (imageFile != null) {
                              // var menu = {
                              //   "Foodname": nameController.text,
                              //   "ingredient": ingredientController.text,
                              //   "recipes": recipeController.text,
                              //   "is_public": isPublic,
                              // };
                              var response = await Cooking().post(
                                  nameController.text,
                                  ingredientController.text,
                                  recipeController.text,
                                  isPublic,
                                  imageFile!.path);
                              if (response.statusCode == 201) {
                                print('success create menu');
                                await setReset(true);
                                int count = 0;
                                Navigator.of(context)
                                    .popUntil((_) => count++ >= 1);
                              } else {
                                setState(() {
                                  error = 'Field could not be blank';
                                });
                              }
                            } else {
                              setState(() {
                                error = 'Field could not be blank';
                              });
                            }
                            print(error);
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
                                  Color.fromARGB(255, 246, 170, 72),
                            ),
                            onPressed: onTap,
                            child: const Text(
                              'ยืนยัน',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: "NotoSansThai",
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          );
                        },
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
