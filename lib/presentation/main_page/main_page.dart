import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/main_page/main_parameters.dart';
import 'package:nem_pho/presentation/main_page/widgets/main_page_body.dart';
import 'package:nem_pho/ui/widgets/not_working.dart';
import '../../ui/widgets/custom/banners/custom_banners.dart';
import '../../ui/widgets/cart_icon.dart';
import '../../ui/widgets/custom/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.mainParameters});

  final MainParameters mainParameters;

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
        MainPageBody(menu: widget.mainParameters.menu)
      ],
    ),
  );
}