import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';
import 'package:nem_pho/presentation/product_page/product_provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/widgets/custom/custom_shimmer.dart';
import 'package:nem_pho/core/widgets/app_bar/custom_appbar.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/presentation/product_page/models/topping_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id});
  final String id;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  final GlobalKey widgetKey = GlobalKey();

  int _getPrice(ProductModel product, int weightIndex, List<ToppingModel> myToppings) {
    if(product.prices == null) return 0;

    int price = product.prices![weightIndex];

    for (int i = 0; i < myToppings.length; i++) {
      price += myToppings[i].price;
    }

    return price;
  }

  @override
  void initState() {
    super.initState();
    AppMetricaService().sendLoadingPageEvent('ProductPage');
    context.read<ProductProvider>().getProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ProductProvider>().isLoading) {
      return const CustomShimmer(
          width: 500,
          height: 500
      );
    }

    final provider = context.watch<ProductProvider>();

    final product = provider.product;
    final weight = provider.weightIndex;
    final myToppings = provider.myToppings;

    return AddToCartAnimation(
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
        backgroundColor: const Color(0xffFFFFFF),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(cartKey: cartKey)
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Hero(
                  tag: product.image,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.5),
                    child: Container(
                      key: widgetKey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width - 21,
                          width: MediaQuery.of(context).size.width - 21,
                          placeholder: (context, url) => CustomShimmer(
                            height: MediaQuery.of(context).size.width - 21,
                            width: MediaQuery.of(context).size.width - 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 45,
                    left: 36,
                    right: 24,
                    bottom: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Color(0xff000000),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 52),
                        child: Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      product.weights.length == 1
                          ? Container(
                        height: 38,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFFFF451D),
                            border: Border.all(
                              color: Color(0xFFF0B0B0),
                              width: 2,
                            )),
                        child: Text(
                          '${product.weights.first} гр',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      )
                          : Row(
                        children: [
                          for(int i = 0; i < product.weights.length; i++)
                            Expanded(
                              child: GestureDetector(onTap: () {
                                context.read<ProductProvider>().onTapWeight(i);
                              },
                                child: Container(
                                  height: 38,
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: weight == i
                                          ? Color(0xFFFF451D)
                                          : Colors.grey,
                                      border: Border.all(
                                        color: Color(0xFFF0B0B0),
                                        width: 2,
                                      )),
                                  child: Text(
                                    '${product.weights[i]} гр',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(width: 4),
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Text(
                      //     product.ml,
                      //     style: const TextStyle(
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 11,
                      //         color: Color(0xff000000)
                      //     )
                      // ),
                      const Text(
                        "Состав",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color(0xff000000),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 52),
                        child: Text(
                          product.composition ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      const SizedBox(height: 17),
                      // Text(
                      //     product.ml,
                      //     style: const TextStyle(
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: 11,
                      //         color: Color(0xff000000)
                      //     )
                      // ),
                      if (product.toppings.isNotEmpty)
                        const Text(
                          "Добавьте топпинги",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xff000000),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 137,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.toppings.length,
                    itemBuilder: (context, index) =>
                        GestureDetector(onTap: () {
                          context.read<ProductProvider>().onTapTopping(index);
                        },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: myToppings.contains(product.toppings[index])
                                  ? const Color(0xffD9D9D9).withOpacity(0.9)
                                  : Colors.transparent,
                              border: Border.all(
                                color: myToppings.contains(product.toppings[index])
                                    ? Colors.red // измените цвет на красный
                                    : Colors.transparent,
                              ),
                              borderRadius: myToppings.contains(product.toppings[index])
                                  ? BorderRadius.circular(10.0)
                                  : null,
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: product.toppings[index].image,
                                    fit: BoxFit.cover,
                                    height: 97,
                                    width: 108,
                                    placeholder: (context, url) =>
                                    const CustomShimmer(
                                      height: 97,
                                      width: 108,
                                    ),
                                  ),
                                ),
                                Text(
                                    product.toppings[index].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xff000000)
                                    )
                                ),
                                Row(
                                  children: [
                                    const Text('+'),
                                    const SizedBox(width: 2),
                                    Text(
                                      product.toppings[index].price.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 78)
              ],
            ),
            Positioned(
              bottom: 38,
              left: 25,
              right: 25,
              child: GestureDetector(onTap: () async {
                if (context.read<CommonProvider>().isUser) {
                  if (context.mounted) {
                    await runAddToCartAnimation(widgetKey);
                    List<String> myToppingsId = [];
                    for(int index = 0; index < myToppings.length; index++) {
                      myToppingsId.add(myToppings[index].id);
                    }
                    // await cartKey.currentState!
                    //     .runCartAnimation((++_cartQuantityItems).toString());
                    context.read<CommonProvider>().addProductToBasket(
                        product: product,
                        price: product.prices![weight],
                        toppingIds: myToppingsId
                    );
                  }
                }
                else {
                  if (context.mounted) {
                    context.push('/authorization_page');
                  }
                }
                // final prefs = await SharedPreferences.getInstance();
                // if (mounted) {
                //   if (prefs.getString('phone') == null) {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (context) => const AuthorizationPage(),
                //       ),
                //     );
                //   }
                //   else {
                //     for (var topping in myToppings) {
                //       context.read<CartProvider>().addProduct(topping);
                //     }
                //     context.read<CartProvider>().addProduct(widget.product);
                //     Navigator.of(context).pop();
                //   }
                // }
              },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffFF451D),
                      borderRadius: BorderRadius.circular(200)
                  ),
                  child: Text(
                    "Добавить ${_getPrice(product, weight, myToppings)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xffFFFFFF),
                    ),
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