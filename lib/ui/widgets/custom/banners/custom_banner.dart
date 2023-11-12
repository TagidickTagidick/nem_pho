import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../custom_shimmer.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.imageUrl,
    required this.widget,
  });

  final String imageUrl;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => widget,
      )),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CustomShimmer(
          height: 179,
          width: double.infinity,
        ),
      ),
    );
  }
}
