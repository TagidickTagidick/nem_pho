import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/product_page.dart';
import 'package:nem_pho/ui/widgets/custom/custom_appbar.dart';
import 'package:provider/provider.dart';
import '../../cart_provider.dart';
import '../../models/product_model.dart';
import '../widgets/custom/custom_shimmer.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(
      {super.key, required this.banners, required this.products});

  final List<String> banners;
  final List<ProductModel> products;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final PageController _controller = PageController();

  List banners = [];

  int index = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getBanners();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  void getBanners() async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.ref().child("banners").get();
    banners = dataSnapshot.value as List;
    Timer.periodic(const Duration(seconds: 5), (timer) {
      index++;
      _controller.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: isLoading
            ? Container()
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 179,
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: 1000,
                        allowImplicitScrolling: true,
                        itemBuilder: (context, index) => CachedNetworkImage(
                          imageUrl:
                              widget.banners[index % widget.banners.length],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CustomShimmer(
                            height: 179,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                        top: 27, left: 26, right: 10, bottom: 27),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          for (ProductModel product in widget.products)
                            Row(
                              children: [
                                Hero(
                                  tag: product.title,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductPage(product: product))),
                                    child: Stack(
                                      children: [
                                        Container(
                                            height: 180,
                                            width: 180,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "images/${product.image}.png"),
                                                    fit: BoxFit.cover))),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child:
                                                Image.asset("images/hit.png"))
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color(0xff000000))),
                                      Text(product.text,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9,
                                              color: Color(0xff000000))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${product.price} р",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                  color: Color(0xff000000))),
                                          GestureDetector(
                                            onTap: () => context
                                                .read<CartProvider>()
                                                .addProduct(product),
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF7F3F3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200)),
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
                  ),
                ],
              ),
      );
}
