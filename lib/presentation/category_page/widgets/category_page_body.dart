import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/ui/widgets/custom/custom_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../core/models/product_model.dart';
import '../category_provider/category_provider.dart';

class CategoryPageBody extends StatelessWidget {
  const CategoryPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<CategoryProvider>().isLoading) {
      return SliverPadding(
        padding: const EdgeInsets.only(
            top: 27,
            left: 26,
            right: 10,
            bottom: 27
        ),
        sliver: SliverToBoxAdapter(
          child: Column(
            children: [
              for (int i = 0; i < 6; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomShimmer(
                          width: MediaQuery.of(context).size.width - 36,
                          height: 180
                      )
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.only(
          top: 27,
          left: 26,
          right: 10,
          bottom: 27
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            for (ProductModel product in context.watch<CategoryProvider>().products)
              Row(
                children: [
                  Hero(
                    tag: product.title,
                    child: GestureDetector(
                      // onTap: () => Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             ProductPage(product: product))),
                      child: Stack(
                        children: [
                          Container(
                              height: 180,
                              width: 180,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(product.image),
                                      fit: BoxFit.cover
                                  )
                              )
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset("images/hit.png")
                          )
                        ],
                      ),
                    ),
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
                            product.title,
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
                            GestureDetector(onTap: () {
                              context.push('/product_page/:id');
                            },
                              child: Container(
                                height: 40,
                                width: 120,
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
          ],
        ),
      ),
    );
  }
}