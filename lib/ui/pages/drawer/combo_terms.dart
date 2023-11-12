import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComboTerms extends StatelessWidget {
  const ComboTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          border: Border.all(color: const Color(0xffF8DFDF)),
          borderRadius: BorderRadius.circular(20)),
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
                          child: Icon(Icons.close,
                              color: Color(0xffF66666), size: 43.2)))),
            ],
          ),
          SizedBox(
            height: 249,
            width: double.infinity,
            child: Container(
                child: Image.asset(
              'images/Discount1.png',
              fit: BoxFit.cover,
            )),
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 28,
            ),
            child: Text(
              'Комбо обед с 11:00 до 16:00',
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
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
              '''🥢 При заказе супа и горячего блюда вы получаете комбо обед + напиток на выбор 🥢Вы можете выбрать один напиток: чай или компот 🥢Условия действуют только в указанное время работы кафе 🥢 Комбо обед не может быть комбинирован с другими акциями или предложениями 🥢 Другие позиции с меню могут быть заказаны отдельно по полной стоимости.
                      ''',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 28,
            ),
            child: Text(
              'Наслаждайтесь комбо обедом!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
