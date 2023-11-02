import 'package:flutter/material.dart';

class TextFieldBox extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String? hintText;

  const TextFieldBox({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    this.hintText = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(), // 테두리 추가
          hintText: hintText,
          contentPadding: const EdgeInsets.only(top: 16, left: 10, right: 10),
        ),
      ),
    );
  }
}
