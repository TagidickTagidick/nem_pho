import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../pages/drawer/menu_item_page.dart';

class MenuTile extends StatefulWidget {
  const MenuTile({super.key});

  @override
  State<MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late AnimationController _controller;
  //
  // static const List<String> menuTileItems = [
  //   "Супы",
  //   "Лапша в соусе",
  //   "Салаты",
  //   "Рис",
  //   "Закуски",
  //   "Напитки",
  //   "Вкусняшки"
  // ];

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      GestureDetector(
        onTap: () {
          if (isExpanded) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
          isExpanded = !isExpanded;
        },
        child: Row(
            children: [
              const SizedBox(width: 39),
              const Expanded(
                  child: Text(
                      "Меню",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  )
              ),
              Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xff000000)
              ),
              const SizedBox(width: 29.01)
            ]
        )
      ),
      const Divider(color: Color(0xffF0E0E0)),
      GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          // Navigator
          //     .of(context)
          //     .push(MaterialPageRoute(builder: (context) => CategoryPage(
          //     banners: categories[0].banners,
          //     products: categories[0].products
          // )));
        },
        child: SizeTransition(
            sizeFactor: _controller.view,
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref("menu").onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData) {
                  List<String> menu = [];
                  Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.data?.snapshot.value));
                  data.forEach((key, value) {
                    menu.add(key);
                  });
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < menu.length; i++)
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => MenuItemPage(menuItem: menu[i]))),
                            child: Container(
                              color: Colors.transparent,
                                padding: const EdgeInsets.only(left: 60),
                                child: Text(
                                    menu[i],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                        color: Color(0xff000000)
                                    )
                                )
                            ),
                          )
                      ]
                  );
                }
                return Container();
              }
            )
        )
      )
    ]
  );
}