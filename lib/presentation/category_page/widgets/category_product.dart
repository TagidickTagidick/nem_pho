import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/widgets/custom/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/providers/common_provider.dart';

class CategoryProduct extends StatelessWidget {
  CategoryProduct({super.key, required this.product, required this.onClick});

  final ProductModel product;
  final void Function(GlobalKey, ProductModel) onClick;

  final GlobalKey widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/product_page/${product.id}');
      },
      child: Row(
        children: [
          Hero(
            tag: product.title,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    key: widgetKey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                        placeholder: (context, url) {
                          return CustomShimmer(
                            height: 150,
                            width: 150,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Container(
                //     height: 180,
                //     width: 180,
                //     margin: const EdgeInsets.symmetric(vertical: 4),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         image: DecorationImage(
                //             image: NetworkImage(product.image),
                //             fit: BoxFit.cover
                //         )
                //     )
                // ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset("images/hit.png"))
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xff000000))),
                Text(product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
                        color: Color(0xff000000))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${product.prices?.firstOrNull} р",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xff000000))),
                    GestureDetector(onTap: () async {
                        if (context.read<CommonProvider>().isUser) {
                          if (context.mounted) {
                            onClick(widgetKey, product);
                          }
                        } else {
                          if (context.mounted) {
                            context.push('/authorization_page');
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xffF7F3F3),
                            borderRadius: BorderRadius.circular(200)),
                        child: const Text(
                          "Выбрать",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
