import 'package:flutter/cupertino.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      color: const Color(0xffFFB627),
      alignment: Alignment.center,
      child: const Text(
        "Сохранить",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF000000)
        ),
      ),
    );
  }
}