import 'package:flutter/material.dart';
import 'package:nem_pho/core/widgets/custom/custom_shimmer.dart';

class MainPageShimmer extends StatelessWidget {
  const MainPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
          top: 27,
          left: 26,
          right: 10,
          bottom: 27
      ),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 13.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
            childCount: 6,
                (BuildContext context, int index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CustomShimmer(
                      width: MediaQuery.of(context).size.width - 36,
                      height: 180
                  )
              );
            }
        ),
      ),
    );
  }
}