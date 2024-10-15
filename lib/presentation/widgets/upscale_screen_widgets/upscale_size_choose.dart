import 'package:flutter/material.dart';

class UpscaleSizeChoose extends StatefulWidget {
  const UpscaleSizeChoose(
    this._formkey, {
    super.key,
  });
  final _formkey;
  @override
  State<UpscaleSizeChoose> createState() => _UpscaleSizeChooseState();
}

class _UpscaleSizeChooseState extends State<UpscaleSizeChoose> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        key: widget._formkey,
        borderRadius: BorderRadius.circular(25),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        dropdownColor: const Color(0xFFFF35B8),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        hint: const Text(
          "Select upscale size",
        ),
        value: dropdownValue,
        items: const [
          DropdownMenuItem(
            value: "2",
            child: Center(child: Text("2x")),
          ),
          DropdownMenuItem(
            value: "4",
            child: Center(child: Text("4x")),
          ),
          DropdownMenuItem(
            value: "6",
            child: Center(child: Text("6x")),
          ),
          DropdownMenuItem(
            value: "8",
            child: Center(child: Text("8x")),
          ),
        ],
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value;
          });
        });
  }
}
