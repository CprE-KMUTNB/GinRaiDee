// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/PicWid.dart';
import 'package:ginraid/Screens/Cooking/bgCook3.dart';
import 'package:ginraid/Screens/Cooking/foodrequest.dart';
import 'package:ginraid/Screens/Cooking/textFieldwid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_debouncer/tap_debouncer.dart';



class EditFoodScreen extends StatefulWidget {
  static const routeName = '/';

  int id;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isPublic;
  EditFoodScreen({
    required this.id,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isPublic,
  });

  @override
  State<StatefulWidget> createState() {
    return _EditFoodScreenState(
        id: id,
        foodname: foodname,
        foodpic: foodpic,
        ingredient: ingredient,
        recipes: recipes,
        isPublic: isPublic);
  }
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  int id;
  String foodname;
  String foodpic;
  String ingredient;
  String recipes;
  bool isPublic;
  _EditFoodScreenState({
    required this.id,
    required this.foodname,
    required this.foodpic,
    required this.ingredient,
    required this.recipes,
    required this.isPublic,
  });
  String? _retrieveDataError;
  
  File? imageFile;
  bool isedit = false;

  Future<bool> setReset(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('reset', state);
  }

  
  String? selectedValue = '';
  String error = ''; ////////////////////////////////////////

  final _dropdownFormKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          value: "?????????????????????",
          child: Text(
            '?????????????????????',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: "NotoSansThai",
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          )),
      DropdownMenuItem(
          value: "?????????????????????",
          child: Text(
            '?????????????????????',
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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    String privacy = isPublic ? "?????????????????????" : "?????????????????????";

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
              //?????????1
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //?????????????????????????????? ??????????????????????????????????????????
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text(
                    '??????????????????????????????????????????',
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

          //???????????????????????????
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
                    SizedBox(height: 10),

                    //????????????????????????
                    TextFieldWidget(
                      maxLines: 1,
                      label: '????????????????????????',
                      text: foodname,
                      onChanged: (text) {
                        setState(() {
                          foodname = text;
                        });
                      },
                    ),

                    //icon???????????????????????????????????????????????? ?????????
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                                iconSize: 35,
                                icon: Icon(Icons.image_outlined),
                                onPressed: () {
                                  setState(() {
                                    isedit = true;
                                  });
                                  getImage(source: ImageSource.gallery);
                                }),
                          ),
                          Container(
                            child: IconButton(
                                iconSize: 35,
                                icon: Icon(Icons.camera_alt_rounded),
                                onPressed: () {
                                  setState(() {
                                    isedit = true;
                                  });
                                  getImage(source: ImageSource.camera);
                                }),
                          )
                        ],
                      ),
                    ),

                    //????????? ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????? backend ????????????????????????????????????
                    ProfileWidget(
                      imagePath: foodpic,
                      imageFile: imageFile,
                      isEdit: isedit,
                      onClicked: () async {},
                    ),

                    SizedBox(height: 20),

                    //????????????????????????
                    TextFieldWidget(
                      maxLines: null,
                      label: '????????????????????????',
                      text: ingredient,
                      onChanged: (text) {
                        setState(() {
                          ingredient = text;
                        });
                      },
                    ),

                    SizedBox(height: 20),

                    //??????????????????
                    TextFieldWidget(
                      maxLines: null,
                      label: '??????????????????',
                      text: recipes,
                      onChanged: (text) {
                        setState(() {
                          recipes = text;
                        });
                      },
                    ),

                    //????????????????????????????????????????????????????????????
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
                                  hintText: '?????????????????????????????????????????????',
                                  hintStyle: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "NotoSansThai",
                                    color: Color.fromARGB(255, 179, 190, 190),
                                  ),
                                  labelText: '?????????????????????????????????????????????',
                                  labelStyle: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "NotoSansThai",
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                validator: (value) =>
                                    value == null ? "?????????????????????????????????????????????" : null,
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

                    //??????????????????????????????
                    Container(
                      width: 120,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: TapDebouncer(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            var menu = {
                              "Foodname": foodname,
                              "ingredient": ingredient,
                              "recipes": recipes,
                              "is_public": isPublic,
                            };

                            if (isedit && imageFile != null) {
                              var response =
                                  await Cooking().putimage(id, imageFile!.path);
                              if (response.statusCode == 200) {
                                print('successupdateimage');
                              } else {
                                setState(() {
                                  error = 'Image could not be blank';
                                });
                              }
                            }

                            var response = await Cooking().put(id, menu);
                            if (response.statusCode == 200) {
                              print('success update menu');
                              await setReset(true);
                              int count = 0;
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 2);
                            } else {
                              setState(() {
                                error = 'Field could not be blank';
                              });
                            }
                            print(error);
                            // print(foodname);
                            // print(ingredient);
                            // print(recipes);
                            // print(isPublic);
                            // print(isedit);
                            // print(imageFile);
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
                              '??????????????????',
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

                    GestureDetector(
                      onTap: () => {showAlertDialog()},
                      child: RichText(
                        text: TextSpan(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            TextSpan(
                              text: '???????????????????????????????????? ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "NotoSansThai",
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            TextSpan(
                              text: '???????????????????????????',
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
              '??????????????????',
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "NotoSansThai",
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
            content: const Text(
              '????????????????????????????????????????????????????????????????????????',
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
                  '??????????????????',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "NotoSansThai",
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              TapDebouncer(
                onTap: () async {
                  var response = await Cooking().delete(id);
                  if (response.statusCode == 204) {
                    print('success delete menu');
                    await setReset(true);
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 3);
                  }
                }, // your tap handler moved here
                builder: (BuildContext context, TapDebouncerFunc? onTap) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: onTap,
                    child: const Text(
                      '??????',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "NotoSansThai",
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  void getImage({required ImageSource source}) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 10);

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
