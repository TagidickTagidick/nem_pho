import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';
import '../../models/product_model.dart';
import '../widgets/custom_appbar.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar()
      ),
      body: Stack(
          children: [
            Column(
                children: [
                  Hero(
                      tag: product.id,
                      child: Container(
                          height: MediaQuery.of(context).size.width - 21,
                          width: MediaQuery.of(context).size.width - 21,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage("images/${product.image}.png"),
                                  fit: BoxFit.cover
                              )
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 45,
                          left: 36,
                          right: 24,
                          bottom: 80
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                product.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Color(0xff000000)
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 52),
                                child: Text(
                                    product.text,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 9,
                                        color: Color(0xff000000)
                                    )
                                )
                            ),
                            const SizedBox(height: 17),
                            Text(
                                product.ml,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    color: Color(0xff000000)
                                )
                            ),
                            const Text(
                                "Добавьте топпинги",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Color(0xff000000)
                                )
                            )
                          ]
                      )
                  ),
                  SizedBox(
                      height: 137,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.toppings.length,
                          itemBuilder: (context, index) => Column(
                              children: [
                                Image.asset(
                                    "images/${product.toppings[index].image}.png"
                                ),
                                Text(
                                    product.toppings[index].text,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: Color(0xff000000)
                                    )
                                )
                              ]
                          )
                      )
                  )
                ]
            ),
            Positioned(
                bottom: 38,
                left: 0,
                right: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 40,
                          width: 140,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xffFF451D),
                              borderRadius: BorderRadius.circular(200)
                          ),
                          child: const Text(
                              "Меню",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xffFFFFFF)
                              )
                          )
                      ),
                      GestureDetector(
                          onTap: () => context.read<CartProvider>().addToCart(product),
                          child: Container(
                              height: 40,
                              width: 140,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(color: const Color(0xffEEB7B7))
                              ),
                              child: const Text(
                                  "Добавить",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xff000000)
                                  )
                              )
                          )
                      )
                    ]
                )
            )
          ]
      )
  );
}