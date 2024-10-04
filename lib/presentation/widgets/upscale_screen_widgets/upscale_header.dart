import 'package:flutter/material.dart';

class UpscaleHeader extends StatelessWidget {
  const UpscaleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Text(
          "Instantly upscale images online with AI",
          style: TextStyle(
            color: Color(0xFFFF35B8),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Paint a clear picture with crispy-clear image quality. Effortlessly bump the pixel count in your images with the Picsart AI image upscaler. All that’s required is a use of a single button, and you can increase the pixel count by up to 4x the original. ",
          textAlign: TextAlign.center,
        ),
        Divider(),
        SizedBox(
          height: 15,
        ),
        Text(
          "How to enlarge images with the AI upscaler",
          style: TextStyle(
              color: Color(0xFFFF35B8),
              fontSize: 24,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
