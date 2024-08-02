import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cart_provider.dart';
import '../../models/product_model.dart';
import '../../ui/widgets/custom/custom_shimmer.dart';
import '../../ui/widgets/custom/custom_appbar.dart';
import '../../ui/pages/drawer/profile/authorization_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> toppings = [];
  List<ProductModel> myToppings = [];

  int price = 0;

  bool isLoading = true;

  bool isHalf = false;

  @override
  void initState() {
    super.initState();
    getToppings();
  }

  void getToppings() async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.ref().child("toppings").get();
    Map<String, dynamic> data = jsonDecode(jsonEncode(dataSnapshot.value));
    for (var item in data.values) {
      toppings.add(ProductModel.fromJson(item));
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        body: Stack(
          children: [
            ListView(
              children: [
                Hero(
                  tag: widget.product.title,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
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
                if (!isLoading)
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
                          widget.product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: Color(0xff000000),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 52),
                          child: Text(
                            widget.product.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 9,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        widget.product.gramm.length == 1
                            ? GestureDetector(
                                onTap: () {
                                  isHalf = false;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 38,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: isHalf
                                          ? Color(0xFFFFFFFF)
                                          : Color(0xFFFF451D),
                                      border: Border.all(
                                        color: Color(0xFFF0B0B0),
                                        width: 2,
                                      )),
                                  child: Text(
                                    '${widget.product.gramm.first} гр',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        isHalf = false;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 38,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: isHalf
                                                ? Color(0xFFFFFFFF)
                                                : Color(0xFFFF451D),
                                            border: Border.all(
                                              color: Color(0xFFF0B0B0),
                                              width: 2,
                                            )),
                                        child: Text(
                                          '${widget.product.gramm.first} гр',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        isHalf = true;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 38,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: isHalf
                                              ? Color(0xFFFF451D)
                                              : Color(0xFFFFFFFF),
                                          border: Border.all(
                                            color: Color(0xFFF0B0B0),
                                            width: 2,
                                          ),
                                        ),
                                        child: Text(
                                          '${widget.product.gramm.last} гр',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                            widget.product.compound,
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
                    itemCount: toppings.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (myToppings.contains(toppings[index])) {
                          myToppings.remove(toppings[index]);
                          price -= int.parse(toppings[index].price);
                          setState(() {});
                        } else {
                          myToppings.add(toppings[index]);
                          price += int.parse(toppings[index].price);
                          setState(() {});
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: myToppings.contains(toppings[index])
                              ? const Color(0xffD9D9D9).withOpacity(0.9)
                              : Colors.transparent,
                          border: Border.all(
                            color: myToppings.contains(toppings[index])
                                ? Colors.red // измените цвет на красный
                                : Colors.transparent,
                          ),
                          borderRadius: myToppings.contains(toppings[index])
                              ? BorderRadius.circular(10.0)
                              : null,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: toppings[index].image,
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
                            Text(toppings[index].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Color(0xff000000))),
                            Row(
                              children: [
                                Text('+'),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  toppings[index].price,
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
              child: GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  if (mounted) {
                    if (prefs.getString('phone') == null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthorizationPage(),
                        ),
                      );
                    }
                    else {
                      for (var topping in myToppings) {
                        context.read<CartProvider>().addProduct(topping);
                      }
                      context.read<CartProvider>().addProduct(widget.product);
                      Navigator.of(context).pop();
                    }
                  }
                    },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xffFF451D),
                      borderRadius: BorderRadius.circular(200)),
                  child: Text(
                    "Добавить ${int.parse(isHalf ? widget.product.price2! : widget.product.price) + price}",
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
      );
}
