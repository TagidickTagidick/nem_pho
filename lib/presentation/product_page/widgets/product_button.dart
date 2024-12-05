import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../product_provider/product_provider.dart';

class ProductButton extends StatelessWidget {
  ProductButton({super.key, required this.onClick});

  final GlobalKey widgetKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 38,
      left: 25,
      right: 25,
      child: GestureDetector(
        onTap: () async {
          if (await context.read<ProductProvider>().checkUser()) {
            if (context.mounted) {
              onClick(widgetKey);
              //context.read<ProductProvider>().addProductToBasket();
            }
          }
          else {
            if (context.mounted) {
              context.push('/authorization_page');
            }
          }
          // final prefs = await SharedPreferences.getInstance();
          // if (mounted) {
          //   if (prefs.getString('phone') == null) {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const AuthorizationPage(),
          //       ),
          //     );
          //   }
          //   else {
          //     for (var topping in myToppings) {
          //       context.read<CartProvider>().addProduct(topping);
          //     }
          //     context.read<CartProvider>().addProduct(widget.product);
          //     Navigator.of(context).pop();
          //   }
          // }
        },
        child: Container(
          height: 40,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffFF451D),
              borderRadius: BorderRadius.circular(200)
          ),
          child: Text(
            "Добавить }",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
