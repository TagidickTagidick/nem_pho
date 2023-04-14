import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 21),
            decoration: BoxDecoration(
              color: const Color(0xffF6F6F6),
              border: Border.all(
                  color: const Color(0xffF8DFDF)
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
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
                Center(
                    child: Image.asset("images/drawer/drawer_logo.png")
                ),
                Center(
                    child: Image.asset("images/drawer/drawer_title.png")
                ),
                GestureDetector(
                    onTap: () {
                      if (isExpanded) {
                        _controller.reverse();
                      } else {
                        _controller.forward();
                      }
                      isExpanded = !isExpanded;
                    },
                    child: Row(
                        children: [
                          const SizedBox(width: 39),
                          const Expanded(
                              child: Text(
                                  "О нас",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Color(0xff000000)
                                  )
                              )
                          ),
                          Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: const Color(0xff000000)
                          ),
                          const SizedBox(width: 29.01)
                        ]
                    )
                ),
                const Divider(color: Color(0xffF0E0E0)),
                SizeTransition(
                    sizeFactor: _controller.view,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 9,
                          horizontal: 31
                      ),
                      child: Text(
                          "Привет, друг!\n\n"
                              "17.01.2019 Открылось новое кафе NEM PHO национальной вьетнамской кухни.\n\n"
                              "Если вы любите восточную культуру, были в Азии, в частности во Вьетнаме, то вам обязательно стоит к нам зайти.\n\n"
                              "Если вам нравится азиатская кухня или просто любите вкусно поесть, то вам тоже непременно к нам.\n\n"
                              "Кафе NEM PHO подарит вам возможность:\n"
                              "🥢Попробовать традиционные вьетнамские блюда от вьетнамских поваров\n"
                              "🥢Всегда свежие, натуральные продукты\n"
                              "🥢Отзывчивый персонал\n"
                              "🥢Демократичные цены\n"
                              "🥢Различные акции\n"
                              "🥢Ваше мнение важно для нас\n"
                              "🥢Побыть туристом в маленьком Вьетнаме с большими вкусовыми колоритами",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Color(0xff000000)
                          )
                      )
                    )
                )
              ]
            )
          ),
          const SizedBox(height: 23),
          Container(
            margin: const EdgeInsets.only(
              left: 17,
              right: 25
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF6F6F6),
              border: Border.all(
                color: const Color(0xffF8DFDF)
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                      "🥢Телефон: +7 (930) 128-44-79\n"
                          "🥢Адрес: Ярославль, Свердлова 34\n\n"
                          "График работы\n"
                          "пн - вс - 11:00 - 21:00"
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 9
                  ),
                    child: Image.asset("images/drawer/drawer_icons.png")
                )
              ]
            )
          )
        ]
      )
    )
  );
}