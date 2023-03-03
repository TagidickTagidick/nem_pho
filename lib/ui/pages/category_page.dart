import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/product_page.dart';
import 'package:nem_pho/ui/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';
import '../../models/product_model.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.banners,
    required this.products
  });

  final List<String> banners;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar()
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 179,
            child: PageView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) => Image.asset(
                    "images/${banners[index]}.png",
                    height: 179,
                    width: double.infinity,
                    fit: BoxFit.cover
                )
            )
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 27,
              left: 26,
              right: 10,
              bottom: 27
            ),
            child: Column(
              children: [
                for (ProductModel product in products)
                  Row(
                      children: [
                        Hero(
                          tag: product.id,
                          child: GestureDetector(
                              onTap: () => Navigator
                                  .of(context)
                                  .push(MaterialPageRoute(
                                  builder: (context) => ProductPage(product: product)
                              )),
                            child: Stack(
                              children: [
                                Container(
                                    height: 180,
                                    width: 180,
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: AssetImage("images/${product.image}.png"),
                                            fit: BoxFit.cover
                                        )
                                    )
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Image.asset("images/hit.png")
                                )
                              ]
                            )
                          )
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      product.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Color(0xff000000)
                                      )
                                  ),
                                  Text(
                                      product.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9,
                                          color: Color(0xff000000)
                                      )
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${product.price} р",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                color: Color(0xff000000)
                                            )
                                        ),
                                        GestureDetector(
                                            onTap: () => context.read<CartProvider>().addToCart(product),
                                            child: Container(
                                                height: 40,
                                                width: 110,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xffF7F3F3),
                                                    borderRadius: BorderRadius.circular(200)
                                                ),
                                                child: const Text(
                                                    "Выбрать",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14,
                                                        color: Color(0xff000000)
                                                    )
                                                )
                                            )
                                        )
                                      ]
                                  )
                                ]
                            )
                        )
                      ]
                  )
              ]
            )
          )
        ]
      )
    )
  );
}