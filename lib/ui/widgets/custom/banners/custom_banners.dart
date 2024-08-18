import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/custom/banners/custom_banner.dart';
import '../../../../presentation/loading_page/models/banner_model.dart';
import '../../../pages/drawer/delivery_info_page.dart';

class CustomBanners extends StatefulWidget {
  const CustomBanners({super.key, required this.banners});

  final List<BannerModel> banners;

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
      if (index == widget.banners.length - 1) {
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
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 179,
        child: PageView.builder(
          controller: _controller,
          allowImplicitScrolling: true,
          itemCount: widget.banners.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomBanner(
              widget: const DeliveryPage(),
              imageUrl: widget.banners[index].url,
            );
          },
        ),
      ),
    );
  }
}