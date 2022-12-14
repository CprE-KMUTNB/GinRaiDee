// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ginraid/Screens/Cooking/textFieldwid.dart';
import 'package:ginraid/Screens/SettingScreen/ProfilePicWid.dart';
import 'package:ginraid/Screens/SettingScreen/bgSet.dart';
import 'package:ginraid/Screens/SettingScreen/settingrequest.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

Future<dynamic> setUsername(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('username', value);
}

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/';

  String username;
  String userPic;

  EditProfileScreen({
    required this.username,
    required this.userPic,
  });

  @override
  State<StatefulWidget> createState() {
    return _EditProfileScreenState(username: username, userPic: userPic);
  }
}

Future<bool> setReset(bool state) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('reset', state);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _retrieveDataError;
  File? imageFile;
  String username;
  String userPic;
  bool isEdit = false;
  String error = ''; ////////////////////////////////////

  _EditProfileScreenState({
    required this.username,
    required this.userPic,
  });

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgSet().buildBackground(screenWidth, screenHeight),
          Container(
            // color:Colors.amber,
            margin: EdgeInsets.only(top: 100),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  alignment: Alignment.topLeft,
                  // color: Colors.black,
                  child: Text(
                    '????????????????????????????????????',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "NotoSansThai",
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
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
            height: screenHeight * 0.74,
            margin: const EdgeInsets.only(top: 165),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),

                    ProfilePicWidget(
                      imagePath: userPic,
                      imageFile: imageFile,
                      isEdit: isEdit,
                      onClicked: () async {
                        optionDialog();
                      },
                    ),

                    //????????? ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????? backend ????????????????????????????????????

                    SizedBox(height: 40),

                    //???????????????????????????
                    TextFieldWidget(
                      maxLines: 1,
                      label: 'Username',
                      text: username,
                      onChanged: (text) {
                        setState(() {
                          username = text;
                        });
                      },
                    ),

                    SizedBox(height: 40),

                    //??????????????????????????????
                    Container(
                      width: 120,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: TapDebouncer(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (isEdit &&
                                imageFile != null &&
                                username.isNotEmpty) {
                              var response =
                                  await Userdata().putimage(imageFile!.path);
                              if (response.statusCode == 200) {
                                print('successupdateimage');
                              } else {
                                setState(() {
                                  error = 'Image could not be blank';
                                });
                              }
                            }

                            if (isEdit &&
                                imageFile == null &&
                                username.isNotEmpty) {
                              var response = await Userdata().deleteimage();

                              if (response.statusCode == 200) {
                                print('successdeleteimage');
                              } else {
                                print(response.statusCode);
                                setState(() {
                                  error = 'Image could not be blank';
                                });
                              }
                            }

                            if (username.isEmpty) {
                              setState(() {
                                error = 'Username could not be blank';
                              });
                            }

                            if (username.isNotEmpty) {
                              var response =
                                  await Userdata().changeusername(username);
                              if (response.statusCode == 200) {
                                print('success update username');
                                await setUsername(username);
                                await setReset(true);
                                int count = 0;
                                Navigator.of(context)
                                    .popUntil((_) => count++ >= 1);
                              } else {
                                setState(() {
                                  error = 'This username cannot be use';
                                });
                                showusernameError();
                              }
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
                                  Color.fromARGB(255, 136, 68, 106),
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
            '?????????????????????',
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
          content: const Text(
            '???????????????????????????????????????????????????????????????????????????',
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                // Write code to delete item
              },
              child: const Text(
                '?????????????????????',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "NotoSansThai",
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void optionDialog() {
    showDialog(
      builder: (context) => SimpleDialog(
        title: Text(
          '??????????????????????????????????????????',
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: "NotoSansThai",
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: Text(
              '????????????????????????',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            onPressed: () {
              getImage(source: ImageSource.gallery);
              setState(() {
                isEdit = true;
              });
            },
          ),
          SimpleDialogOption(
            child: Text(
              '???????????????',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            onPressed: () {
              getImage(source: ImageSource.camera);
              setState(() {
                isEdit = true;
              });
            },
          ),
          SimpleDialogOption(
            child: Text(
              '????????????????????????????????????',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 255, 0, 0),
              ),
            ),
            onPressed: () {
              setState(() {
                userPic =
                    'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png';
                isEdit = true;
                imageFile = null;
              });
              //?????????????????????????????????????????????????????????????????????????????????
            },
          ),
          SimpleDialogOption(
            child: Text(
              '??????????????????',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "NotoSansThai",
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      context: context,
    );
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

  void showusernameError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "username ???????????????????????????????????????????????????????????????",
            style: TextStyle(
                fontSize: 20.0, fontFamily: "Itim", fontWeight: FontWeight.bold
                // color: Color.fromARGB(255, 166, 198, 6),
                ),
          ),
          content: Text(
            '??????????????????????????????????????? username ????????????',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: "Itim",
              // color: Color.fromARGB(255, 166, 198, 6),
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: const Text(
                "????????????",
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
