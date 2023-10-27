import 'package:flutter/material.dart';

class WeHave extends StatelessWidget {
  const WeHave({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration:BoxDecoration(
            color: const Color(0xffF3F3F3),
            border: Border.all(
                color: const Color(0xffF8DFDF)
            ),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            ),
            SizedBox(
              height: 249,
              width: double.infinity,
              child: Container(
                  child: Image.asset('images/Discount2.png',
                    fit: BoxFit.cover,)
              ),
            ), SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28
              ),
              child: Text('Прямо из Вьетнама',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),),
            ),
            SizedBox(
              height: 42,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
              ),
              child: Text(
                '''🥢  Приветствуем вас в нашем кафе! Здесь вы сможете найти уникальные продукты прямо из замечательной страны Вьетнам. 🇻🇳

🍜 Мы гордимся тем, что предлагаем разнообразные необычные продукты, чтобы удовлетворить любителей вьетнамской кухни и тех, кто ищет новые вкусы:

🥢Превосходные виды риса, включая духмяный жасминовый рис и коричневый вьетнамский рис.

🥢Ароматные специи и соусы, такие как рыбный соус нуок мам, пикантный карри-порошок и травяной базилик.

🥢Особенные виды соуса для приправы и маринадов, в том числе густой и сладкий соус хойсин и пикантный соус с свежими перцем.

🥢Традиционные вьетнамские продукты, например, свежие рисовые листья банана для упаковки популярного блюда вьетнамские свежие рулеты "гой куон" и многое другое.

✨ Обратите внимание, что наш ассортимент может меняться в зависимости от доступности и сезональности продуктов.
                        ''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height:
              20,
            ),
          ],
        ),
      ),
    );
  }
}
