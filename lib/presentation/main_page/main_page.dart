import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/core/widgets/order_icon.dart';
import 'package:nem_pho/presentation/main_page/widgets/main_page_body.dart';
import 'package:nem_pho/core/widgets/not_working.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/widgets/banners/custom_banners.dart';
import 'package:nem_pho/core/widgets/app_bar/cart_icon.dart';
import 'package:nem_pho/core/widgets/drawer/custom_drawer.dart';

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
      actions: const [OrderIcon(), CartIcon()],
    ),
    drawer: const CustomDrawer(),
    body: RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: NotWorking()),
          const CustomBanners(),
          const MainPageBody(),
          SliverToBoxAdapter(
            child: MaterialButton(
              height: 10,
                onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => _Da()));
            }),
          )
        ],
      ),
    ),
  );
}

class _Da extends StatefulWidget {
  const _Da();

  @override
  State<_Da> createState() => _DaState();
}

class _DaState extends State<_Da> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String test = '';
  String test2 = '';

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  Future<void> _getBatteryLevel() async {
    //test2 = (await AppMetrica.requestDeferredDeeplinkParameters()).toString();
    String batteryLevel;
    try {
      print("оыоы");
      final result = await platform.invokeMethod<String>('getBatteryLevel');
      print("оыоы1");
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      test = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              test,
              style: TextStyle(
                  color: Colors.black
              ),
            ),
            Text(
              test2,
              style: TextStyle(
                  color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
