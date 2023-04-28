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
  List<int> myToppings = [];

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar()
      ),
      body: Stack(
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
                          bottom: 80
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
                      child: StreamBuilder(
                        stream: FirebaseDatabase.instance.ref("toppings").onValue,
                        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                          if (snapshot.hasData) {
                            List<ToppingModel> toppings = [];
                            Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.data?.snapshot.value));
                            for (var item in data.values) {
                              toppings.add(ToppingModel.fromJson(item));
                            }
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: toppings.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    if (myToppings.contains(index)) {
                                      myToppings.remove(index);
                                      setState(() {

                                      });
                                    }
                                    else {
                                      myToppings.add(index);
                                      setState(() {

                                      });
                                    }
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: myToppings.contains(index)
                                              ? Colors.black
                                              : Colors.transparent)
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
                                            )
                                          ]
                                      )
                                  )
                                )
                            );
                          }
                          return Container();
                        },
                      )
                  ),
                  const SizedBox(height: 78)
                ]
            ),
            Positioned(
                bottom: 38,
                left: 0,
                right: 0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                        child: Container(
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
                        )
                      ),
                      GestureDetector(
                          onTap: () => context.read<CartProvider>().addToCart(widget.product),
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