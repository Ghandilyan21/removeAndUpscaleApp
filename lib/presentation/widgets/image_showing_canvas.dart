import 'package:flutter/material.dart';

class ImageShowingCanvas extends StatelessWidget {
  Image image;
  ImageShowingCanvas({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFFF35B8),
            width: 7,
          ),
        ),
        child: image,
      ),
    );
  }
}
