import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/topping_model.dart';

import 'menu_model.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key, required this.model});

  final MenuModel model;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                widget.model.image
              )
            )
          ),
        ),
        Text(widget.model.gramm.toString()),
        StreamBuilder(
            stream: FirebaseDatabase.instance.ref("toppings").onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data?.snapshot.value);
                List<ToppingModel> menu = [];
                Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.data?.snapshot.value));
                for (var item in data.values) {
                  ToppingModel model = ToppingModel.fromJson(item);
                  menu.add(model);
                }
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: menu.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Image.network(
                            menu[index].image,
                            width: 100,
                            height: 100,
                          ),
                          Text(
                              menu[index].title
                          ),
                          Text(
                              menu[index].price
                          )
                        ],
                      )
                  )
                );
              }
              else {
                return Container();
              }
            }
        )
      ],
    )
  );
}