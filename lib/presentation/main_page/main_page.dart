import 'package:flutter/material.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/presentation/main_page/widgets/main_page_body.dart';
import 'package:nem_pho/ui/widgets/not_working.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/banners/custom_banners.dart';
import '../../core/widgets/app_bar/cart_icon.dart';
import '../../core/widgets/drawer/custom_drawer.dart';

///Главная страница
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  ///Открывает левую плашку приложения
  void _openDrawer() {
    _key.currentState?.openDrawer();
  }

  ///Обновление экрана
  Future<void> _refresh() async {
    context.read<CommonProvider>().getBanners();
    context.read<CommonProvider>().getMenu();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    key: _key,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: const Color(0xffFFFFFF),
      leading: GestureDetector(
        onTap: _openDrawer,
        child: const Icon(
          Icons.menu,
          color: Color(0xff000000),
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
    body: RefreshIndicator(
      onRefresh: _refresh,
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: NotWorking()),
          CustomBanners(),
          MainPageBody()
        ],
      ),
    ),
  );
}