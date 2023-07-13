import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../screens/dashboard/NavScreen/CategoryScreen.dart';




class CommonImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ValueChanged deleteImage;

  final String buttonText;
  ImageKitRequest? selectedImagePath;


    CommonImageButton({
    required this.onPressed,
    required this.buttonText,
   required this.selectedImagePath,
      required this.deleteImage
  });

  @override
  Widget build(BuildContext context) {
    print("selected image file is $selectedImagePath");
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: selectedImagePath?.imageUrl != null
            ?Stack(
          children: [
            Container(
              color: Colors.transparent, // Set transparent background
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(selectedImagePath!.imageUrl.toString(),height: 100,)), // Replace with your image widget
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  deleteImage(selectedImagePath!);
                  // Handle close button tap
                  // You can add your logic here, such as closing the image or removing it from the UI
                },
              ),
            ),
          ])
            : Image.asset(
          'assets/images/camera_icon.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }


}
