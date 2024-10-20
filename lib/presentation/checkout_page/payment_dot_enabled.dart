import 'package:flutter/material.dart';

class PaymentDotEnabled extends StatelessWidget {
  const PaymentDotEnabled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 26,
      width: 26,
      decoration: const BoxDecoration(
        color: Color(0xffd9d9d9),
        shape: BoxShape.circle,
      ),
      child: Container(
        height: 19,
        width: 19,
        decoration: const BoxDecoration(
          color: Color(0xffff451d),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
