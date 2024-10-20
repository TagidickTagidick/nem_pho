import 'package:flutter/cupertino.dart';
import '../../../core/widgets/custom/custom_shimmer.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
          top: 27,
          left: 26,
          right: 10,
          bottom: 27
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            for (int i = 0; i < 6; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomShimmer(
                        width: MediaQuery.of(context).size.width - 36,
                        height: 180
                    )
                ),
              ),
          ],
        ),
      ),
    );
  }
}