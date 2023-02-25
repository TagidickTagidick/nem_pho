import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/product_page.dart';

import 'menu_model.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref("menu").onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data?.snapshot.value);
            List<MenuModel> menu = [];
            Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.data?.snapshot.value));
            for (var item in data.values) {
              MenuModel model = MenuModel.fromJson(item);
              if (model.isActive) {
                menu.add(model);
              }
            }
            return ListView.builder(
              itemCount: menu.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage(model: menu[index]))),
                  child: Row(
                    children: [
                      Image.network(
                        menu[index].image,
                        width: 100,
                        height: 100,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                                menu[index].title
                            ),
                            Text(
                                menu[index].text
                            ),
                            Text(
                                menu[index].price
                            )
                          ]
                        )
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
  );
}