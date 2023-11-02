import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/drawer/about_app.dart';

class TermUse extends StatelessWidget {
  const TermUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                      Center(
                          child: Image.asset("images/drawer/drawer_logo.png")),
                      Center(
                          child: Image.asset("images/drawer/drawer_title.png")),
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
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AboutApp()));
                          },
                          child: Row(children: [
                            const SizedBox(width: 39),
                            const Expanded(
                                child: Text("Пользовательское соглашение",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Color(0xff000000)))),
                            const SizedBox(width: 29.01)
                          ])),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Добро пожаловать в наше приложение кафе! Мы рады приветствовать вас и надеемся, что наше приложение станет для вас полезным инструментом.',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Пользовательское соглашение (далее - "Соглашение") является юридическим документом, регулирующим использование приложения кафе (далее - "Приложение"). Пожалуйста, ознакомьтесь с этим Соглашением перед использованием Приложения. Использование Приложения означает ваше согласие с условиями этого Соглашения.',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Права и обязанности пользователя. \n\n'
                        '1.1. Пользователь обязуется использовать Приложение только в законных целях. \n\n'
                        '1.2. Пользователь не имеет права копировать, распространять или модифицировать Приложение или его компоненты без предварительного разрешения правообладателя.\n\n'
                        '1.3. Пользователь обязуется не нарушать права других пользователей Приложения.\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Права и обязанности правообладателя. \n\n'
                        '2.1. Все права на Приложение и его компоненты принадлежат правообладателю. \n\n'
                        '2.2. Правообладатель имеет право изменять состав компонентов Приложения, а также правила использования Приложения. \n\n'
                        '2.3. Правообладатель не несет ответственности за действия пользователей, нарушающих условия Соглашения. \n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ограничение ответственности. \n\n'
                        '3.1. Приложение предоставляется "как есть". Правообладатель не гарантирует бесперебойную работу Приложения и не несет ответственности за возможные проблемы, связанные с использованием Приложения.\n\n'
                        '3.2. Правообладатель не несет ответственности за возможный ущерб, причиненный пользователю в результате использования Приложения. \n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Разрешение споров. \n\n'
                        '4.1. Все споры, связанные с использованием Приложения, решаются путем переговоров между сторонами.\n\n'
                        '4.2. Если спор не может быть разрешен путем переговоров, он передается на рассмотрение в судебные органы по месту нахождения правообладателя.\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Заключительные положения. \n\n'
                        '5.1. Настоящее Соглашение является юридическим документом, определяющим условия использования Приложения.\n\n'
                        '5.2. Пользователь подтверждает, что он ознакомился с условиями Соглашения и принимает их.\n\n'
                        '5.3. Правообладатель имеет право изменять условия Соглашения в любое время без предварительного уведомления пользователя.\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'С уважением,Команда приложения кафе',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Divider(color: Color(0xffF0E0E0)),
                    ])),
              ],
            ),
          ),
        ),
      );
}
