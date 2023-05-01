import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/cart_page.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => Navigator
          .of(context)
          .push(
          MaterialPageRoute(
              builder: (context) => CartPage(
                  cart: context.read<CartProvider>().products,
                toppings: context.read<CartProvider>().toppings
              )
          )
      ),
      child: Container(
          width: 50,
          padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5
          ),
          child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      "images/cart.png",
                      height: 31,
                      width: 31,
                    )
                ),
                if (context.watch<CartProvider>().products.isNotEmpty)
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          height: 23,
                          width: 23,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Color(0xffFF451D),
                              shape: BoxShape.circle
                          ),
                          child: Text(
                              context.watch<CartProvider>().products.length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xffFFFFFF)
                              )
                          )
                      )
                  )
              ]
          )
      )
  );
}