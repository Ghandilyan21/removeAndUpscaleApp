import 'package:flutter/material.dart';

class RemoveBgHeader extends StatelessWidget {
  const RemoveBgHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Text(
          "Free background remover",
          style: TextStyle(
            color: Color(0xFFFF35B8),
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Remove backgrounds from photos quickly and precisely with Picsart’s AI-powered background eraser. ",
          textAlign: TextAlign.center,
        ),
        Divider(),
        SizedBox(
          height: 15,
        ),
        Text(
          "How to remove backgrounds in seconds",
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
