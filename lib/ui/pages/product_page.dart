import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';
import '../../models/menu_model.dart';
import '../../models/topping_model.dart';
import '../widgets/custom_appbar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ToppingModel> toppings = [];
  List<ToppingModel> myToppings = [];

  int price = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    price = int.parse(widget.product.price);
    getToppings();
  }

  void getToppings() async {
    DataSnapshot dataSnapshot = await FirebaseDatabase
        .instance
        .ref()
        .child("toppings")
        .get();
    Map<String, dynamic> data = jsonDecode(jsonEncode(dataSnapshot.value));
    for (var item in data.values) {
      toppings.add(ToppingModel.fromJson(item));
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar()
      ),
      body: isLoading
          ? Container()
          : Stack(
          children: [
            ListView(
                children: [
                  Hero(
                      tag: widget.product.title,
                      child: Container(
                          height: MediaQuery.of(context).size.width - 21,
                          width: MediaQuery.of(context).size.width - 21,
                          margin: const EdgeInsets.symmetric(horizontal: 10.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(widget.product.image),
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
                          bottom: 30
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.product.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 32,
                                    color: Color(0xff000000)
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 52),
                                child: Text(
                                    widget.product.text,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 9,
                                        color: Color(0xff000000)
                                    )
                                )
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
                          itemCount: toppings.length,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                if (myToppings.contains(toppings[index])) {
                                  myToppings.remove(toppings[index]);
                                  price -= int.parse(toppings[index].price);
                                  setState(() {});
                                }
                                else {
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
                                    // border: Border.all(
                                    //     color: myToppings.contains(index)
                                    //     ? Colors.black
                                    //     : Colors.transparent
                                    // )
                                  ),
                                  child: Column(
                                      children: [
                                        Image.network(
                                            toppings[index].image,
                                            height: 97,
                                            width: 108
                                        ),
                                        Text(
                                            toppings[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                                color: Color(0xff000000)
                                            )
                                        ),
                                        Text(
                                            toppings[index].price,
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
                      )
                  ),
                  const SizedBox(height: 78)
                ]
            ),
            Positioned(
                bottom: 38,
                left: 25,
                right: 25,
                child: GestureDetector(
                    onTap: () {
                      context.read<CartProvider>().addProduct(widget.product);
                      for (var topping in myToppings) {
                        context.read<CartProvider>().addTopping(topping);
                      }
                      Navigator.of(context).pop();
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
                            "Добавить $price",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xffFFFFFF)
                            )
                        )
                    )
                )
            )
          ]
      )
  );
}