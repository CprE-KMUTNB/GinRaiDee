import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  final File? imageFile;

  ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.imageFile,
    required this.isEdit,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          // Positioned(
          //   bottom: 0,
          //   right: 4,
          //   child: buildEditIcon(color),
          // ),
        ],
      ),
    );
  }

  late double screenWidth, screenHeight;
  Widget buildImage() {
    final imageold = NetworkImage(imagePath);

    if (imageFile != null && isEdit == true) {
      final imagenew = FileImage(imageFile!);
      return Container(
          height: 180,
          width: screenWidth,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            image: DecorationImage(
              image: imagenew,
            ),
          ),
          child: GestureDetector(onTap: onClicked));
    }

    return Container(
        height: 180,
        width: screenWidth,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          image: DecorationImage(
            image: imageold,
          ),
        ),
        child: GestureDetector(onTap: onClicked));

    // return ClipOval(
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Ink.image(
    //       image: image,
    //       fit: BoxFit.cover,
    //       width: 128,
    //       height: 128,
    //       child: InkWell(onTap: onClicked),
    //     ),
    //   ),
    // );
  }

  // Widget buildEditIcon(Color color) => buildCircle(
  //       color: Colors.white,
  //       all: 3,
  //       child: buildCircle(
  //         color: color,
  //         all: 8,
  //         child: Icon(
  //           isEdit ? Icons.add_a_photo : Icons.edit,
  //           color: Colors.white,
  //           size: 20,
  //         ),
  //       ),
  //     );

  // Widget buildCircle({
  //   required Widget child,
  //   required double all,
  //   required Color color,
  // }) =>
  //     ClipOval(
  //       child: Container(
  //         padding: EdgeInsets.all(all),
  //         color: color,
  //         child: child,
  //       ),
  //     );
}
