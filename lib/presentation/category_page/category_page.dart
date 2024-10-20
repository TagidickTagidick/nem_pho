import 'package:flutter/material.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/presentation/category_page/category_provider/category_provider.dart';
import 'package:nem_pho/presentation/category_page/widgets/category_page_body.dart';
import 'package:nem_pho/core/widgets/app_bar/custom_appbar.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/banners/custom_banners.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.id
  });

  final String id;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  int index = 0;

  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().getProducts(widget.id);
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar()
    ),
    body: RefreshIndicator(onRefresh: () async {
      context.read<CategoryProvider>().refresh(widget.id);
      context.read<CommonProvider>().getBanners();
    },
      child: const CustomScrollView(
        slivers: [
          CustomBanners(),
          CategoryPageBody()
        ],
      ),
    ),
  );
}