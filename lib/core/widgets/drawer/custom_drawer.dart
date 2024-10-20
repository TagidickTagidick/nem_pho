import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/presentation/about_app_page/about_app_page.dart';
import 'package:nem_pho/presentation/about_us/about_us.dart';
import 'package:nem_pho/presentation/delivery_page/delivery_page.dart';
import 'package:nem_pho/presentation/promotions/discounts_page.dart';
import 'package:provider/provider.dart';
import 'menu_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) => Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                        padding: EdgeInsets.only(right: 10.69),
                        child: Icon(
                            Icons.close,
                            color: Color(0xffF66666),
                            size: 43.2
                        )
                    )
                )
            ),
            Center(child: Image.asset("images/drawer/drawer_logo.png")),
            Center(child: Image.asset("images/drawer/drawer_title.png")),
            const MenuTile(),
            GestureDetector(onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StockPage())
            ),
              child: const Padding(
                  padding: EdgeInsets.only(left: 39),
                  child: Text(
                      "Акции",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  )
              ),
            ),
            const Divider(color: Color(0xffF0E0E0)),
            GestureDetector(onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutUs())
            ),
                child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(left: 39),
                    child: const Text(
                        "О нас",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000)
                        )
                    )
                )
            ),
            const Divider(color: Color(0xffF0E0E0)),
            GestureDetector(onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutAppPage())
            ),
                child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(left: 39),
                    child: const Text(
                        "О приложении",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000)
                        )
                    )
                )
            ),
            const Divider(color: Color(0xffF0E0E0)),
            GestureDetector(onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                const DeliveryPage(),
                )
            ),
                child: const Padding(
                    padding: EdgeInsets.only(left: 39),
                    child: Text(
                        "Доставка",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000)
                        )
                    )
                )
            ),
            const Divider(color: Color(0xffF0E0E0)),
            GestureDetector(onTap: () async {
              if(await context.read<CommonProvider>().checkIsAuthorized()) {
                context.push('/profile_page');
              } else {
                context.push('/authorization_page');
              }
            },
                child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(left: 39),
                    child: const Text(
                        "Профиль",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff000000)
                        )
                    )
                )
            ),
            const Divider(color: Color(0xffF0E0E0)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 39),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Ярославль",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  ),
                  const Text(
                      "8-900-500-500",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0xff000000)
                      )
                  ),
                  Image.asset("images/drawer/drawer_icons.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}