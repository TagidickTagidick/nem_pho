import 'package:flutter/material.dart';
import 'cart_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.isLogin,
    this.isCart,
    this.cartKey,
  });

  final bool? isLogin;
  final bool? isCart;
  final Key? cartKey;

  @override
  Widget build(BuildContext context) => AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: GestureDetector(
            onTap: () => isLogin == null
                ? Navigator.of(context).pop()
                : Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Icon(Icons.arrow_back_ios, color: Color(0xff000000))),
        centerTitle: false,
        title: const Text(
          "NEM PHO",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xff000000),
          ),
        ),
        actions: isCart == null ? [CartIcon(cartKey: cartKey)] : null,
      );

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
