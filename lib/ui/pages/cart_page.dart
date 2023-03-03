import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';
import '../../models/product_model.dart';
import '../widgets/custom_appbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cart});

  final List<ProductModel> cart;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductModel> newCart = [];
  List<int> counts = [];

  @override
  void initState() {
    super.initState();
    List<ProductModel> oldCart = widget.cart;
    if (oldCart.isNotEmpty) {
      oldCart.sort((a, b) => a.id.compareTo(b.id));
      if (oldCart.length == 1) {
        newCart = [oldCart[0]];
        counts = [1];
      } else {
        int count = 0;
        for (int i = 1; i < oldCart.length; i++) {
          count++;
          if (oldCart[i].id != oldCart[i - 1].id) {
            newCart.add(oldCart[i - 1]);
            counts.add(count);
            count = 0;
          }
        }
        count++;
        newCart.add(oldCart[oldCart.length - 1]);
        counts.add(count);
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar()
      ),
      body: SingleChildScrollView(
          child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 28,
                        bottom: 7
                    ),
                    child: Text(
                        "Корзина",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Color(0xff000000)
                        )
                    )
                ),
                for (int i = 0; i < newCart.length; i++)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            newCart[i].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xff000000)
                            )
                        ),
                        Text(
                            "${newCart[i].price} р",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xff000000)
                            )
                        ),
                        Container(
                            width: 120,
                            margin: const EdgeInsets.symmetric(vertical: 17),
                            child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                          onTap: () {
                                            counts[i]--;
                                            context.read<CartProvider>().removeProduct(newCart[i]);
                                            if (counts[i] == 0) {
                                              newCart.removeAt(i);
                                              counts.removeAt(i);
                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                              height: 37,
                                              width: 60,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(37),
                                                      bottomLeft: Radius.circular(37)
                                                  ),
                                                  border: Border.all(color: const Color(0xff000000))
                                              ),
                                              child: const Icon(
                                                  Icons.remove,
                                                  color: Color(0xff000000)
                                              )
                                          )
                                      )
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                          onTap: () {
                                            counts[i]++;
                                            context.read<CartProvider>().addProduct(newCart[i]);
                                            setState(() {});
                                          },
                                          child: Container(
                                              height: 37,
                                              width: 60,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(37),
                                                      bottomRight: Radius.circular(37)
                                                  ),
                                                  border: Border.all(color: const Color(0xff000000))
                                              ),
                                              child: const Icon(
                                                  Icons.add,
                                                  color: Color(0xff000000)
                                              )
                                          )
                                      )
                                  ),
                                  Center(
                                    child: Container(
                                      height: 38,
                                      width: 38,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFF451D)
                                      ),
                                      child: Text(
                                          counts[i].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 24,
                                              color: Color(0xffFFFFFF)
                                          )
                                      )
                                    )
                                  )
                                ]
                            )
                        )
                      ]
                  ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 15,
                      left: 14,
                      right: 6
                  ),
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 17,
                    right: 16
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Доставка:",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xff000000)
                            )
                          ),
                          Text(
                              "Ярославль",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Color(0xff000000)
                              )
                          )
                        ]
                      )
                    ]
                  )
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 31,
                    left: 29,
                    bottom: 4
                  ),
                  child: Text(
                    "Оплата",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    )
                  )
                )
              ]
          )
      )
  );
}