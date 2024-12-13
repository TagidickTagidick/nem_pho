import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:provider/provider.dart';

class OrderIcon extends StatefulWidget {
  const OrderIcon({super.key, this.cartKey});

  final Key? cartKey;

  @override
  State<OrderIcon> createState() => _OrderIconState();
}

class _OrderIconState extends State<OrderIcon> {
  @override
  Widget build(BuildContext context) {
    if(!context.read<CommonProvider>().isUser || context.read<CommonProvider>().orders.isEmpty) {
      return SizedBox();
    }
    return GestureDetector(onTap: () async {
      context.push('/checkout_page');
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
                Icons.access_time_rounded,
                color: Colors.black,
              ),
            ),
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
                  context.watch<CommonProvider>().orders.length.toString(),
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
}