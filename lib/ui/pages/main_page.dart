import 'package:flutter/material.dart';
import 'package:nem_pho/models/menu_model.dart';
import 'package:nem_pho/models/product_model.dart';
import 'package:nem_pho/models/topping_model.dart';
import 'package:nem_pho/ui/pages/category_page.dart';
import 'package:nem_pho/ui/widgets/menu_tile.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';
import '../widgets/cart_icon.dart';

List<CategoryModel> categories = [
  CategoryModel(
      text: "Супы",
      image: "Супы",
      banners: [
        "main_page_view"
      ],
      products: [
        ProductModel(
            id: "1",
            title: "Фо бо",
            text: "Фо бо классический - это вьетнамский суп, который состоит из рисовой лапши, мяса говядины, наваристого бульона и зелени",
            image: "Фо бо",
            badge: "hit",
            ml: "500/750/1000 мл",
            price: 300,
            toppings: [
              ToppingModel(
                  text: "Ростки бобов",
                  image: "Ростки бобов"
              ),
              ToppingModel(
                  text: "Вьет острый перец",
                  image: "Вьет острый перец"
              )
            ]
        ),
        ProductModel(
            id: "2",
            title: "Фо га",
            text: "Фо га вьетнамский суп, который состоит из рисовой лапши, курицы, наваристого бульона и зелени",
            image: "Фо га",
            badge: null,
            ml: "500/750/1000 мл",
            price: 280,
            toppings: [
              ToppingModel(
                  text: "Ростки бобов",
                  image: "Ростки бобов"
              ),
              ToppingModel(
                  text: "Вьет острый перец",
                  image: "Вьет острый перец"
              )
            ]
        )
      ]
  ),
  CategoryModel(
      text: "Напитки",
      image: "Напитки",
      banners: [
        "main_page_view"
      ],
      products: [
        ProductModel(
            id: "2",
            title: "Фо бо",
            text: "Фо бо классический - это вьетнамский суп, который состоит из рисовой лапши, мяса говядины, наваристого бульона и зелени",
            image: "Фо бо",
            badge: "hit",
            ml: "500/750/1000 мл",
            price: 300,
            toppings: [
              ToppingModel(
                  text: "Ростки бобов",
                  image: "Ростки бобов"
              ),
              ToppingModel(
                  text: "Вьет острый перец",
                  image: "Вьет острый перец"
              )
            ]
        )
      ]
  ),
  CategoryModel(
      text: "Закуски",
      image: "Закуски",
      banners: [
        "main_page_view"
      ],
      products: [
        ProductModel(
            id: "3",
            title: "Фо бо",
            text: "Фо бо классический - это вьетнамский суп, который состоит из рисовой лапши, мяса говядины, наваристого бульона и зелени",
            image: "Фо бо",
            badge: "hit",
            ml: "500/750/1000 мл",
            price: 300,
            toppings: [
              ToppingModel(
                  text: "Ростки бобов",
                  image: "Ростки бобов"
              ),
              ToppingModel(
                  text: "Вьет острый перец",
                  image: "Вьет острый перец"
              )
            ]
        )
      ]
  ),
  CategoryModel(
      text: "Рис",
      image: "Рис",
      banners: [
        "main_page_view"
      ],
      products: [
        ProductModel(
            id: "4",
            title: "Фо бо",
            text: "Фо бо классический - это вьетнамский суп, который состоит из рисовой лапши, мяса говядины, наваристого бульона и зелени",
            image: "Фо бо",
            badge: "hit",
            ml: "500/750/1000 мл",
            price: 300,
            toppings: [
              ToppingModel(
                  text: "Ростки бобов",
                  image: "Ростки бобов"
              ),
              ToppingModel(
                  text: "Вьет острый перец",
                  image: "Вьет острый перец"
              )
            ]
        )
      ]
  ),
  CategoryModel(
      text: "Лапша",
      image: "Лапша",
      banners: [
        "main_page_view"
      ],
      products: [
        ProductModel(
            id: "5",
            title: "Фо бо",
            text: "Фо бо классический - это вьетнамский суп, который состоит из рисовой лапши, мяса говядины, наваристого бульона и зелени",
            image: "Фо бо",
            badge: "hit",
            ml: "500/750/1000 мл",
            price: 300,
            toppings: [
              ToppingModel(
                  text: "Ростки бобов",
                  image: "Ростки бобов"
              ),
              ToppingModel(
                  text: "Вьет острый перец",
                  image: "Вьет острый перец"
              )
            ]
        )
      ]
  ),
  CategoryModel(
      text: "Салаты",
      image: "Салаты",
      banners: [
        "main_page_view"
      ],
      products: [
        ProductModel(
            id: "6",
            title: "Фо бо",
            text: "Фо бо классический - это вьетнамский суп, который состоит из рисовой лапши, мяса говядины, наваристого бульона и зелени",
            image: "Фо бо",
            badge: "hit",
            ml: "500/750/1000 мл",
            price: 300,
            toppings: [
              ToppingModel(
                  text: "Ростки бобов",
                  image: "Ростки бобов"
              ),
              ToppingModel(
                  text: "Вьет острый перец",
                  image: "Вьет острый перец"
              )
            ]
        )
      ]
  )
];

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) => Scaffold(
    key: _key,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: const Color(0xffFFFFFF),
      leading: GestureDetector(
        onTap: () => _key.currentState?.openDrawer(),
        child: const Icon(
            Icons.menu,
          color: Color(0xff000000)
        )
      ),
      centerTitle: false,
      title: const Text(
        "NEM PHO",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: Color(0xff000000)
        )
      ),
      actions: const [
        CartIcon()
      ]
    ),
    drawer: Drawer(
      child: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10.69),
                        child: Icon(
                            Icons.close,
                            color: Color(0xffF66666),
                            size: 43.2
                        )
                      )
                  )
              ),
              Center(
                  child: Image.asset("images/drawer/drawer_logo.png")
              ),
              Center(
                  child: Image.asset("images/drawer/drawer_title.png")
              ),
              const MenuTile(),
              const Padding(
                  padding: EdgeInsets.only(left: 39),
                  child: Text(
                      "Акции",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  )
              ),
              const Divider(color: Color(0xffF0E0E0)),
              const Padding(
                  padding: EdgeInsets.only(left: 39),
                  child: Text(
                      "О нас",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  )
              ),
              const Divider(color: Color(0xffF0E0E0)),
              const Padding(
                  padding: EdgeInsets.only(left: 39),
                  child: Text(
                      "Доставка",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  )
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 3,
                      left: 39
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "Личный кабинет",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Color(0xff000000)
                          )
                      ),
                      const SizedBox(height: 3),
                      const Text(
                          "Ярославль",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Color(0xff000000)
                          )
                      ),
                      const Text(
                          "8-900-500-500",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Color(0xff000000)
                          )
                      ),
                      Image.asset(
                          "images/drawer/drawer_icons.png"
                      )
                    ],
                  )
              )
            ]
        )
      )
    ),
    body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Image.asset(
                "images/main_page_view.png",
                height: 179,
                width: double.infinity,
                fit: BoxFit.cover
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 13,
              right: 12,
              bottom: 10
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 13.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) => Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/${categories[index].image}.png"
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator
                                .of(context)
                                .push(MaterialPageRoute(
                                builder: (context) => CategoryPage(
                                  banners: categories[index].banners,
                                    products: categories[index].products,
                                )
                            )),
                            child: Container(
                                height: 34,
                                width: 119,
                                margin: const EdgeInsets.only(bottom: 17),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color(0xffFF451D),
                                    borderRadius: BorderRadius.circular(200)
                                ),
                                child: Text(
                                    categories[index].text,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Color(0xffFFFFFF)
                                    )
                                )
                            )
                          )
                      ),
                  childCount: categories.length
              )
            )
          )
        ]
    ),
  );
}