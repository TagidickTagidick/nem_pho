import 'package:flutter/material.dart';

class DishDay extends StatelessWidget {
  const DishDay({super.key});

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
                  child: Image.asset('images/Discount3.png',
                    fit: BoxFit.cover,)
              ),
            ), SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28
              ),
              child: Text('Блюдо дня',
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
                '''Открывай страницу до конца и раскрой тайну нашего загадочного блюда дня!


🥢Сегодня наш главный шеф приготовил что-то по-настоящему оригинальное и пикантное – блюдо, которое заполонит ваш вкусовой репертуар сочными ароматами и уникальными вкусами. Это необычное блюдо является настоящим сокровищем в нашем меню, и его секреты скрыты глубоко!



🥢 Полистайте вниз, чтобы раскрыть тайну! Окунитесь в уникальный мир вьетнамской гастрономии и готовьтесь испытать великолепие ароматов и вкусов, присущих древней культуре Вьетнама. 
''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 42,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
              ),
              child: Text(
                '''🥢 [Здесь начинается раскрытие тайны и описание блюда дня...] 

[Описание блюда со всеми его неповторимыми деталями, ингредиентами и текстурой...]
 
''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
              ),
              child: Text(
                '''🥢 Вот и наше таинственное блюдо дня - эмблема вьетнамской кухни, объединяющая в себе трепетный баланс вкусов и душистых ароматов, которые оставят вас в полном восторге!


🥢 Так что, не медлите, продолжайте свое путешествие, чтобы полностью раскрыть кулинарное сокровище этого дня. Насладитесь неподражаемым вкусом и удовлетворите свои гастрономические ожидания. Блюдо дня ждет вас на самом дне этой страницы! 🌟✨🙌 
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
            SizedBox(
              height: 249,
              width: double.infinity,
              child: Container(
                  child: Image.asset('images/Лапша.png',
                    fit: BoxFit.cover,)
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 60
              ),
              child: Text('БУН ХАЙ САН',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 39,
                color: Colors.black
              ),),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
              ),
              child: Text(
                '''Акция действует только при оплате заказа на кассе в ресторане НЭМ ФО. Акция не действует при заказе онлайн 
''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
