import 'package:flutter/material.dart';
import 'package:nem_pho/core/widgets/custom/mask_text_input_formatter.dart';

class EnterField extends StatelessWidget {
   EnterField({super.key, required this.phoneController, required this.checkCanSignIn});

   final TextEditingController phoneController;

  final maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final void Function(String) checkCanSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: const Color(0xffF3F3F3),
      padding: const EdgeInsets.only(left: 36),
      child: TextField(
        controller: phoneController,
        maxLength: 18,
        autofocus: true,
        cursorHeight: 26,
        cursorColor: const Color(0xffff9900),
        onChanged: checkCanSignIn,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Colors.white.withOpacity(0.3)
          ),
        ),
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Color(0xff6D6D6D)
        ),
        inputFormatters: [maskFormatter],
      ),
    );
  }
}
