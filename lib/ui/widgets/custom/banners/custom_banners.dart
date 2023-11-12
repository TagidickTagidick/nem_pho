import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/custom/banners/custom_banner.dart';
import '../../../pages/drawer/about_app.dart';
import '../../../pages/drawer/delivery_info_page.dart';
import '../../../pages/drawer/discounts_page.dart';
import '../../../pages/drawer/menu_item_page.dart';
import '../custom_shimmer.dart';

class CustomBanners extends StatefulWidget {
  const CustomBanners({super.key});

  @override
  State<CustomBanners> createState() => _CustomBannersState();
}

class _CustomBannersState extends State<CustomBanners> {
  final PageController _controller = PageController();
  late final Timer _timer;

  late final List banners;

  int index = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getBanners();
  }

  void getBanners() async {
    DataSnapshot dataSnapshot =
        await FirebaseDatabase.instance.ref().child("banners").get();
    banners = dataSnapshot.value as List;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index == banners.length - 1) {
        index = 0;
        _controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      } else {
        index++;
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
    isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: isLoading
          ? const CustomShimmer(
              height: 179,
              width: double.infinity,
            )
          : SizedBox(
              height: 179,
              child: PageView(
                controller: _controller,
                allowImplicitScrolling: true,
                children: [
                  CustomBanner(
                    widget: const DeliveryPage(),
                    imageUrl: banners[0],
                  ),
                  CustomBanner(
                    widget: const MenuItemPage(menuItem: 'Напитки'),
                    imageUrl: banners[1],
                  ),
                  CustomBanner(
                    widget: const AboutApp(),
                    imageUrl: banners[2],
                  ),
                  CustomBanner(
                    widget: const StockPage(),
                    imageUrl: banners[3],
                  ),
                ],
              ),
            ),
    );
  }
}
