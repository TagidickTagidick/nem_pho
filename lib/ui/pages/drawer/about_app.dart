import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/drawer/about_app_tile.dart';
import 'package:video_player/video_player.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp>
    with SingleTickerProviderStateMixin {
  bool isExpanded = true;

  late AnimationController _controller;

  late VideoPlayerController _videoPlayerController;

  bool isPlaying = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _controller.forward();
    _videoPlayerController = VideoPlayerController.asset('images/video.mp4');
    _videoPlayerController.initialize();
    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.value.isPlaying) {
        isPlaying = false;
        setState(() {});
      } else {
        isPlaying = true;
        setState(() {});
      }
    });
    super.initState();
  }

  int selectedIndex = -1;

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;

  @override
  Widget build(BuildContext context) => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 21),
          decoration: BoxDecoration(
              color: const Color(0xffF6F6F6),
              border: Border.all(color: const Color(0xffF8DFDF)),
              borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Padding(
                        padding: EdgeInsets.only(right: 10.69),
                        child: Icon(Icons.close,
                            color: Color(0xffF66666), size: 43.2)))),
            Center(child: Image.asset("images/drawer/drawer_logo.png")),
            Center(child: Image.asset("images/drawer/drawer_title.png")),
            SizedBox(
              height: 10,
            ),
            Text(
              "IP",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AboutAppTile(
                title: "Пользовательское соглашение",
                text:
                    "'Добро пожаловать в наше приложение кафе! Мы рады приветствовать вас и надеемся, что наше приложение станет для вас полезным инструментом.'\n\n"),
            // GestureDetector(
            //     onTap: () {
            //       if (isExpanded) {
            //         _controller.reverse();
            //       } else {
            //         _controller.forward();
            //       }
            //       isExpanded = !isExpanded;
            //     },
            //     child: Row(
            //         children: [
            //           const SizedBox(width: 39),
            //           const Expanded(
            //               child: Text(
            //                   "Пользовательское соглашение",
            //                   style: TextStyle(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 20,
            //                       color: Color(0xff000000)
            //                   )
            //               )
            //           ),
            //           Icon(
            //               isExpanded
            //                   ? Icons.keyboard_arrow_up
            //                   : Icons.keyboard_arrow_down,
            //               color: const Color(0xff000000)
            //           ),
            //           const SizedBox(width: 29.01)
            //         ]
            //     )
            // ),
            // SizeTransition(
            //     sizeFactor: _controller.view,
            //     child: const Padding(
            //         padding: EdgeInsets.symmetric(
            //             vertical: 9,
            //             horizontal: 31
            //         ),
            //       child: Column(
            //         children: [
            //           Text('Добро пожаловать в наше приложение кафе! Мы рады приветствовать вас и надеемся, что наше приложение станет для вас полезным инструментом.',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text('Пользовательское соглашение (далее - "Соглашение") является юридическим документом, регулирующим использование приложения кафе (далее - "Приложение"). Пожалуйста, ознакомьтесь с этим Соглашением перед использованием Приложения. Использование Приложения означает ваше согласие с условиями этого Соглашения.',
            //             style: TextStyle(
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 14
            //             ),),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text('Права и обязанности пользователя. \n\n'
            //               '1.1. Пользователь обязуется использовать Приложение только в законных целях. \n\n'
            //               '1.2. Пользователь не имеет права копировать, распространять или модифицировать Приложение или его компоненты без предварительного разрешения правообладателя.\n\n'
            //               '1.3. Пользователь обязуется не нарушать права других пользователей Приложения.\n\n',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text('Права и обязанности правообладателя. \n\n'
            //               '2.1. Все права на Приложение и его компоненты принадлежат правообладателю. \n\n'
            //               '2.2. Правообладатель имеет право изменять состав компонентов Приложения, а также правила использования Приложения. \n\n'
            //               '2.3. Правообладатель не несет ответственности за действия пользователей, нарушающих условия Соглашения. \n\n',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text('Ограничение ответственности. \n\n'
            //               '3.1. Приложение предоставляется "как есть". Правообладатель не гарантирует бесперебойную работу Приложения и не несет ответственности за возможные проблемы, связанные с использованием Приложения.\n\n'
            //               '3.2. Правообладатель не несет ответственности за возможный ущерб, причиненный пользователю в результате использования Приложения. \n\n',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text('Разрешение споров. \n\n'
            //               '4.1. Все споры, связанные с использованием Приложения, решаются путем переговоров между сторонами.\n\n'
            //               '4.2. Если спор не может быть разрешен путем переговоров, он передается на рассмотрение в судебные органы по месту нахождения правообладателя.\n\n',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text('Заключительные положения. \n\n'
            //               '5.1. Настоящее Соглашение является юридическим документом, определяющим условия использования Приложения.\n\n'
            //               '5.2. Пользователь подтверждает, что он ознакомился с условиями Соглашения и принимает их.\n\n'
            //               '5.3. Правообладатель имеет право изменять условия Соглашения в любое время без предварительного уведомления пользователя.\n\n',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text('С уважением,Команда приложения кафе',
            //             style: TextStyle(
            //               fontWeight: FontWeight.w600,
            //               fontSize: 14,
            //             ),),
            //         ],
            //       ),
            //     )
            // ),
            SizedBox(
              height: 10,
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
                child: Row(children: [
                  const SizedBox(width: 39),
                  const Expanded(
                      child: Text("Политика конфидециальности",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xff000000)))),
                  Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xff000000)),
                  const SizedBox(width: 29.01)
                ])),
            SizeTransition(
                sizeFactor: _controller.view,
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 31),
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
                            color: Color(0xff000000))))),
            SizedBox(
              height: 10,
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
                child: Row(children: [
                  const SizedBox(width: 39),
                  const Expanded(
                      child: Text("Положение об обработке персональных данных",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xff000000)))),
                  Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xff000000)),
                  SizedBox(width: 29.01)
                ])),
            const Divider(color: Color(0xffF0E0E0)),
            SizeTransition(
                sizeFactor: _controller.view,
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 31),
                    child: Text("Описание!3\n\n",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xff000000)))))
          ]),
        ),
      ]))));
}
