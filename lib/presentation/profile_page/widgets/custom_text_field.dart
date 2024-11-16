import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.textEditingController,
    this.isNumber = false,
    super.key
  });

  final TextEditingController textEditingController;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: const Color(0xffF3F3F3),
      child: TextField(
        controller: textEditingController,
        keyboardType: isNumber ? TextInputType.phone : null,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xff000000)
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}