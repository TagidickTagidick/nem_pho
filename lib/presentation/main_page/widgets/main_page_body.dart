import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../ui/widgets/custom/custom_shimmer.dart';
import '../../loading_page/models/menu_model.dart';

class MainPageBody extends StatelessWidget {

  final List<MenuModel> menu;

  const MainPageBody({
    required this.menu,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 13,
          right: 12,
          bottom: 10,
        ),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 13.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: menu.length,
                (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  context.pushNamed('/category_page', pathParameters: {'id': menu[index].id.toString()});
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => MenuItemPage(
                  //         menuItem: menu[index]
                  //     )
                  // ));
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
                          imageUrl: menu[index].image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CustomShimmer(
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
                          menu[index].name,
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
          ),
        )
    );
  }
}