import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/drawer/menu_item_page.dart';
import 'package:nem_pho/ui/widgets/not_working.dart';
import '../../ui/widgets/custom/banners/custom_banners.dart';
import '../../ui/widgets/cart_icon.dart';
import '../../ui/widgets/custom/custom_drawer.dart';
import '../../ui/widgets/custom/custom_shimmer.dart';

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
        child: const Icon(Icons.menu, color: Color(0xff000000),
        ),
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
      actions: const [CartIcon()],
    ),
    drawer: const CustomDrawer(),
    body: CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: NotWorking()),
        const CustomBanners(),
        SliverPadding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 13,
            right: 12,
            bottom: 10,
          ),
          sliver: StreamBuilder(
            stream: FirebaseDatabase.instance.ref("menu").onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData) {
                List<String> menu = [];
                List<String> images = [];
                Map<String, dynamic> data =
                jsonDecode(jsonEncode(snapshot.data?.snapshot.value));
                data.forEach((key, value) {
                  menu.add(key);
                  images.add(value["image"] ?? "");
                });
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300.0,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 13.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MenuItemPage(
                                  menuItem: menu[index]
                              )
                          ));
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: images[index],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                  const CustomShimmer(
                                    height: 179,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
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
                                  menu[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: menu.length,
                  ),
                );
              }
              return SliverToBoxAdapter(
                  child: Container()
              );
            },
          ),
        ),
      ],
    ),
  );
}