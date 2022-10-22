import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  final File? imageFile;

  ProfilePicWidget({
    Key? key,
    required this.imagePath,
    required this.imageFile,
    required this.isEdit,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final imageold = NetworkImage(imagePath);

    if (imageFile != null && isEdit == true) {
      final imagenew = FileImage(imageFile!);
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: imagenew,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(onTap: onClicked),
          ),
        ),
      );
    }

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imageold,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Color.fromARGB(255, 199, 21, 21),
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Color.fromARGB(255, 136, 68, 106),
          child: child,
        ),
      );
}
