import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/presentation/cart_page/cart_provider/cart_provider.dart';
import 'package:nem_pho/presentation/cart_page/constants/cart_constants.dart';
import 'package:nem_pho/presentation/checkout_page/checkout_page.dart';
import 'package:provider/provider.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key, 
    required this.controllers, 
    required this.canOrder, 
    required this.street, required this.isCard, required this.isSelf
  });
  
  final Map<String, TextEditingController> controllers;
  final bool canOrder;
  final String street;
  final bool isCard;
  final bool isSelf;
  
  void _order(BuildContext context) async {
    if (!canOrder) return;

    await context.read<CartProvider>().order(
        phone: controllers[CartConst.phone]!.text,
        building: controllers[CartConst.building]!.text,
        street: street,
        name: controllers[CartConst.name]!.text,
        entrance: controllers[CartConst.entrance]!.text.isEmpty
            ? null
            : int.parse(controllers[CartConst.entrance]!.text),
        floor: controllers[CartConst.floor]!.text.isEmpty
            ? null
            : int.parse(controllers[CartConst.floor]!.text),
        comment: controllers[CartConst.comment]!.text,
        isCard: isCard,
        isSelf: isSelf
    );

    if (!context.mounted) return;

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CheckoutPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWorking = context.watch<CommonProvider>().isWorking;

    if (!isWorking) {
      SliverToBoxAdapter(
        child: const SizedBox(
          height: 60,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Внимание! На данный момент доставка не работает!',
                textAlign: TextAlign.center,
              ),
              Text(
                'Вернитесь в приложение с 11:30 до 19:30',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => _order(context),
        child: Container(
          height: 39,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: canOrder
                  ? const Color(0xff19B80B)
                  : const Color(0xff19B80B).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)
          ),
          child: const Text(
            "Оформить заказ",
            style: TextStyle(
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
