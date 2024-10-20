import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/core/widgets/banners/custom_banner.dart';
import 'package:nem_pho/core/widgets/custom/custom_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/presentation/delivery_page/delivery_page.dart';

class CustomBanners extends StatefulWidget {
  const CustomBanners({super.key});

  @override
  State<CustomBanners> createState() => _CustomBannersState();
}

class _CustomBannersState extends State<CustomBanners> {
  final PageController _controller = PageController();
  Timer? _timer;

  int index = 0;

  @override
  void initState() {
    super.initState();
    _initBanners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index == context.read<CommonProvider>().banners.length - 1) {
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
  }

  void _initBanners() async {
    _startTimer();
    _controller.addListener(() {
      if (_timer != null) {
        _timer!.cancel();
        _startTimer();
      }
    });
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banners = context.watch<CommonProvider>().banners;

    if (context.read<CommonProvider>().isBannersLoading) {
      return SliverToBoxAdapter(
        child: CustomShimmer(
            width: MediaQuery.of(context).size.width,
            height: 179
        ),
      );
    }
    //if (banners.isEmpty) return const SliverToBoxAdapter(child: SizedBox());

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 179,
        child: PageView.builder(
          controller: _controller,
          allowImplicitScrolling: true,
          itemCount: banners.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomBanner(
              widget: const DeliveryPage(),
              imageUrl: banners[index].url,
            );
          },
        ),
      ),
    );
  }
}