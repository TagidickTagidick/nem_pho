import 'package:flutter/cupertino.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({
    super.key,
    required this.pageController
  });

  final PageController pageController;

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  bool isOrders = true;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
        isOrders ? Alignment.centerRight : Alignment.centerLeft,
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
                GestureDetector(onTap: () {
                  widget.pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                  );
                  setState(() => isOrders = false);
                },
                  child: Text(
                    "Мои заказы",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isOrders
                          ? const Color(0xff000000)
                          : const Color(0xffffffff),
                    ),
                  ),
                ),
                GestureDetector(onTap: () {
                  widget.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                  );
                  setState(() => isOrders = true);
                },
                  child: Text(
                    "Данные",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isOrders
                          ? const Color(0xffffffff)
                          : const Color(0xff000000),
                    ),
                  ),
                ),
              ]
          )
      )
    ]);
  }
}