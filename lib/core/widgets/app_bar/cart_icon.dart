import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/cart_provider.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({super.key});

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
          const Align(
            alignment: Alignment.bottomLeft,
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
          if (context.watch<CartProvider>().phone != null
              && context.watch<CartProvider>().userModel!.cart.isNotEmpty)
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
                  context.watch<CartProvider>().userModel!.cart.length.toString(),
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