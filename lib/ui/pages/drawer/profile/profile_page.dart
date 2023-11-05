import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/drawer/profile/my_info.dart';
import 'package:nem_pho/ui/widgets/custom/custom_appbar.dart';
import 'package:nem_pho/ui/widgets/drawer/profile/my_orders.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isStory = false;

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(isLogin: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Stack(children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(
                    color: const Color(0xffF0B0B0),
                  ),
                ),
              ),
              AnimatedAlign(
                alignment:
                    isStory ? Alignment.centerRight : Alignment.centerLeft,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2.0,
                  decoration: BoxDecoration(
                    color: const Color(0xffFF451D),
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: const Color(0xffF0B0B0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _controller.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.ease,
                              );
                              setState(() => isStory = false);
                            },
                            child: Text("Мои заказы",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: isStory
                                        ? const Color(0xff000000)
                                        : const Color(0xffffffff),),),),
                        GestureDetector(
                          onTap: () {
                            _controller.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.ease,
                            );
                            setState(() => isStory = true);
                          },
                          child: Text(
                            "Данные",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: isStory
                                  ? const Color(0xffffffff)
                                  : const Color(0xff000000),
                            ),
                          ),
                        ),
                      ]))
            ]),
            const SizedBox(height: 27),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  MyOrders(),
                  MyInfo(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
