import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({super.key, this.cartKey});

  final Key? cartKey;

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: () async {
    final bool checkUser = await context.read<CommonProvider>().checkIsAuthorized();
    context.push(checkUser ? '/cart_page' : '/authorization_page');
  },
    child: Container(
      width: 50,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Icon(
              key: widget.cartKey,
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
          if (context.watch<CommonProvider>().basket.isNotEmpty)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 23,
                width: 23,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xffFF451D),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  context.watch<CommonProvider>().basket.length.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}