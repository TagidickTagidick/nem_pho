import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';
import 'package:nem_pho/presentation/category_page/category_provider/category_provider.dart';
import 'package:nem_pho/presentation/category_page/widgets/category_page_body.dart';
import 'package:nem_pho/core/widgets/app_bar/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/widgets/banners/custom_banners.dart';
import 'package:nem_pho/core/models/product_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.id
  });

  final String id;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  int index = 0;

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  @override
  void initState() {
    super.initState();
    AppMetricaService().sendLoadingPageEvent('CategoryPage');
    context.read<CategoryProvider>().getProducts(widget.id);
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  void listClick(GlobalKey widgetKey, ProductModel product) async {
    if(product.prices == null) return;

    await runAddToCartAnimation(widgetKey);

    context.read<CommonProvider>().addProductToBasket(
        product: product,
        price: product.prices!.first,
        toppingIds: []
    );
  }

  @override
  Widget build(BuildContext context) => AddToCartAnimation(
    cartKey: cartKey,
    height: 30,
    width: 30,
    opacity: 0.85,
    dragAnimation: const DragToCartAnimationOptions(
      rotation: true,
    ),
    jumpAnimation: const JumpAnimationOptions(),
    createAddToCartAnimation: (runAddToCartAnimation) {
      // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
      this.runAddToCartAnimation = runAddToCartAnimation;
    },
    child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(cartKey: cartKey)
      ),
      body: RefreshIndicator(onRefresh: () async {
        context.read<CategoryProvider>().refresh(widget.id);
        context.read<CommonProvider>().getBanners();
      },
        child: CustomScrollView(
          slivers: [
            CustomBanners(),
            CategoryPageBody(onClick: listClick,)
          ],
        ),
      ),
    ),
  );
}