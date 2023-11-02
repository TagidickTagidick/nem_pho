import 'package:flutter/material.dart';

class PaymentDivider extends StatelessWidget {
  const PaymentDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      width: 59,
      height: 3,
      color: Color(0xffc5e8b0),
    );
  }
}
