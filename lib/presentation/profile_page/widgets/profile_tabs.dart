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
  bool isMyInfo = false;
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
        isMyInfo ? Alignment.centerRight : Alignment.centerLeft,
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
                  setState(() => isMyInfo = false);
                },
                  child: Text(
                    "Мои заказы",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isMyInfo
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
                  setState(() => isMyInfo = true);
                },
                  child: Text(
                    "Данные",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isMyInfo
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