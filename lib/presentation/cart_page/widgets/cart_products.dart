import 'package:flutter/material.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/presentation/cart_page/cart_provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({
    super.key,
    required this.newProducts,
    required this.counts
  });

  final List<ProductModel> newProducts;
  final List<int> counts;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
        return Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                newProducts[i].title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff000000),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${newProducts[i].price} р",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 120,
              margin: const EdgeInsets.symmetric(vertical: 17),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(onTap: () {
                      context.read<CartProvider>().deleteProduct(newProducts[i], i);
                    },
                      child: Container(
                        height: 37,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(37),
                              bottomLeft: Radius.circular(37)),
                          border: Border.all(
                            color: const Color(0xff000000),
                          ),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(onTap: () {
                      context.read<CartProvider>().addProduct(newProducts[i], i);
                    },
                      child: Container(
                        height: 37,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(37),
                            bottomRight: Radius.circular(37),
                          ),
                          border: Border.all(
                            color: const Color(0xff000000),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 38,
                      width: 38,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFF451D)),
                      child: Text(
                        counts[i].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20)
          ],
        );
      },
          childCount: newProducts.length
      ),
    );
  }
}
