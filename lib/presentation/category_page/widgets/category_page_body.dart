import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/category_page/widgets/category_shimmer.dart';
import 'package:nem_pho/presentation/category_page/widgets/category_product.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/presentation/category_page/category_provider/category_provider.dart';

class CategoryPageBody extends StatelessWidget {
  const CategoryPageBody({super.key, required this.onClick});

  final void Function(GlobalKey, ProductModel) onClick;

  @override
  Widget build(BuildContext context) {
    if (context.watch<CategoryProvider>().isLoading) {
      return const CategoryShimmer();
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
              CategoryProduct(
                  product: product,
                onClick: onClick,
              ),
          ],
        ),
      ),
    );
  }
}