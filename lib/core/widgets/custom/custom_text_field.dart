import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 22),
        decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(200),
            border: Border.all(color: const Color(0xffF0B0B0))),
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: const Color(0xff000000).withOpacity(0.42),
            ),
          ),
        ),
      );
}
