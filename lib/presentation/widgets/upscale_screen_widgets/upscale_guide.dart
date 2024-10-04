import 'package:flutter/material.dart';

class UpscaleGuide extends StatelessWidget {
  const UpscaleGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 247, 167, 219),
      ),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "1. Use the Upload button below to select up to three photos to upscale.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                // fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "2. If you want to upscale your image to a specific size, set up your target height and width at the bottom. Or, use the 2x and 4x button to quickly double and quadruple the resolution.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                // fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "3. Once you’re done, use the Export button in the top right corner to save your work and head for the printers!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                // fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
