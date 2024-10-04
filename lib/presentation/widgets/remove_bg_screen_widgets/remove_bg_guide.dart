import 'package:flutter/material.dart';

class RemoveBgGuide extends StatelessWidget {
  const RemoveBgGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 243, 122, 243),
        border: Border.all(
          color: const Color.fromARGB(255, 0, 182, 254),
          width: 3,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "1. Use the Upload image button to get started.",
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
              "2. No need to do anything here, the background eraser does everything automatically.",
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
              "3. Save your edit with a transparent background.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
