import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/product_page.dart';
import '../../../models/product_model.dart';
import '../../widgets/custom/custom_shimmer.dart';
import '../../widgets/custom/custom_appbar.dart';
import '../../widgets/custom/custom_drawer.dart';

class MenuItemPage extends StatefulWidget {
  const MenuItemPage({super.key, required this.menuItem});

  final String menuItem;

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final PageController _controller = PageController();
  Timer? timer;

  List banners = [];

  int index = 0;

  @override
  void initState() {
    super.initState();
    getBanners();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  void getBanners() async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.ref().child("banners").get();
    banners = dataSnapshot.value as List;
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index == banners.length - 1) {
        index = 0;
        _controller.animateToPage(0,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      } else {
        index++;
        _controller.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _key,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppBar()),
        drawer: const CustomDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 179,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: banners.length,
                  itemBuilder: (context, index) => CachedNetworkImage(
                    imageUrl: banners[index],
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
                top: 13,
                left: 18,
                right: 10,
                bottom: 17,
              ),
              sliver: StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .ref("menu/${widget.menuItem}")
                      .onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasData) {
                      List<ProductModel> menu = [];
                      Map<String, dynamic> data =
                          jsonDecode(jsonEncode(snapshot.data?.snapshot.value));
                      data.remove("image");
                      for (var item in data.values) {
                        menu.add(ProductModel.fromJson(item));
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(product: menu[index]))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                child: Row(children: [
                                  Hero(
                                    tag: menu[index].title,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: menu[index].image,
                                        fit: BoxFit.cover,
                                        height: 185,
                                        width: 179,
                                        placeholder: (context, url) =>
                                            const CustomShimmer(
                                          height: 185,
                                          width: 179,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(menu[index].title,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff000000))),
                                        Text(menu[index].text,
                                            style: const TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff000000))),
                                        const SizedBox(height: 38),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${menu[index].price} Р",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      color:
                                                          Color(0xff000000))),
                                              Container(
                                                  height: 40,
                                                  width: 100,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200),
                                                    color:
                                                        const Color(0xffF7F3F3),
                                                    border: Border.all(
                                                      color: Color(0xFFF0B0B0),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: const Text("Выбрать",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xff000000))))
                                            ])
                                      ]))
                                ]),
                              ));
                        }, childCount: menu.length),
                      );
                    }
                    return SliverToBoxAdapter(child: Container());
                  }),
            ),
          ],
        ),
      );
}
