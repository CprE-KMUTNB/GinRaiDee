// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/PicWid.dart';
import 'package:ginraid/Screens/Cooking/addFoodScreen.dart';
import 'package:ginraid/Screens/Cooking/bgCook1.dart';
import 'package:ginraid/Screens/Cooking/bgCook3.dart';
import 'package:ginraid/Screens/Cooking/food.dart';
import 'package:ginraid/Screens/Cooking/myFood.dart';
import 'package:ginraid/Screens/Cooking/textFieldwid.dart';
import 'package:image_picker/image_picker.dart';

import '../Favorite/user.dart';

class EditFoodScreen extends StatefulWidget {
  static const routeName = '/';

  const EditFoodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditFoodScreenState();
  }
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  String? _retrieveDataError;
  Food food = FoodEdit.myFood;
  File? imageFile;

  String? selectedValue = '';
  final _dropdownFormKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: "สาธารณะ",
          child: Text(
            'สาธารณะ',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "NotoSansThai",
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          )),
      DropdownMenuItem(
          value: "ส่วนตัว",
          child: Text(
            'ส่วนตัว',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "NotoSansThai",
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          )),
    ];
    return menuItems;
  }

  late double screenWidth, screenHeight;

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
          bgCook3().buildBackground(screenWidth, screenHeight),
          Container(
            margin: EdgeInsets.only(top: 75),
            child: Row(
              //แถว1
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //ชื่อหัวข้อ แก้ไขเมนูอาหาร
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    'แก้ไขเมนูอาหาร',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "NotoSansThai",
                      color: Colors.white,
                    ),
                  ),
                ),

                Container(
                  child: Icon(
                    Icons.edit_note,
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
                  SizedBox(height: 10),

                  //ชื่อเมนู
                  TextFieldWidget(
                    maxLines: 1,
                    label: 'ชื่อเมนู',
                    text: food.name,
                    onChanged: (name) {},
                  ),

                  //iconเลือกรูปจากกล้อง แกล
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

                  //รูป ติดตรงถ้าเลือกจากโทรศัพท์ให้เปลี่ยนค่าไม่ได้ คิดว่าน่าจะต้องเชื่อ backend เป็นลิ้งก่อน
                  ProfileWidget(
                    imagePath: food.imagePath,
                    isEdit: true,
                    onClicked: () async {},
                  ),

                  SizedBox(height: 20),

                  //วัตถุดิบ
                  TextFieldWidget(
                    maxLines: null,
                    label: 'วัตถุดิบ',
                    text: food.Ingred,
                    onChanged: (Ingred) {},
                  ),

                  SizedBox(height: 20),

                  //วิธีทำ
                  TextFieldWidget(
                    maxLines: null,
                    label: 'วิธีทำ',
                    text: food.cookMethod,
                    onChanged: (cookMethod) {},
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
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              validator: (value) =>
                                  value == null ? "ความเป็นส่วนตัว" : null,
                              dropdownColor: Color.fromARGB(255, 255, 255, 255),
                              value: food.privacy,
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

                  //ปุ่มบันทึก
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
                        'บันทึก',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "NotoSansThai",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => {showAlertDialog()},
                    child: RichText(
                      text: TextSpan(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          TextSpan(
                            text: 'ต้องการที่จะ ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "NotoSansThai",
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextSpan(
                            text: 'ลบเมนูนี้',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "NotoSansThai",
                              color: Color.fromARGB(255, 227, 0, 0),
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
        ],
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'ลบเมนู',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold
              ),
            ),
            content: const Text(
              'คุณต้องการที่จะลบเมนูนี้',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
                
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 179, 190, 190)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "NotoSansThai",
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  // Write code to delete item
                },
                child: const Text(
                  'ลบ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "NotoSansThai",
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          );
        });
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
