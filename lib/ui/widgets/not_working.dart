import 'package:flutter/material.dart';
import 'package:nem_pho/cart_provider.dart';
import 'package:provider/provider.dart';

class NotWorking extends StatelessWidget {
  const NotWorking({super.key});

  @override
  Widget build(BuildContext context) {
    return context.watch<CartProvider>().isWorking ? const SizedBox() : const SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Внимание! На данный момент доставка не работает!',
            textAlign: TextAlign.center,
          ),
          Text(
            'Вернитесь в приложение с 11:30 до 20:30',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
