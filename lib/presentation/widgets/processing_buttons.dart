import 'package:flutter/material.dart';

class ProcessingButtons extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback? processImage;
  final VoidCallback? saveImage;
  const ProcessingButtons({super.key, required this.firstText, required this.secondText, required this.processImage, required this.saveImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: processImage,
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFFFF35B8))),
          child: Text(
            firstText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        OutlinedButton(
                  onPressed: saveImage,
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFFFF35B8))),
                  child: Text(
                    secondText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
      ],
    );
  }
}
