import 'package:flutter/material.dart';

class PaymentDot extends StatelessWidget {
  const PaymentDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 26,
      width: 26,
      decoration: BoxDecoration(
        color: Color(0xffd9d9d9),
        shape: BoxShape.circle,
      ),
    );
  }
}
