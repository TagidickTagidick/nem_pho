import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/pay/payment_card.dart';
import 'package:nem_pho/ui/pages/pay/second_stape.dart';
import 'package:nem_pho/ui/widgets/custom/custom_appbar.dart';

class PaymentStape extends StatelessWidget {
  const PaymentStape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 61,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 19,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Оплата',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(
                          0xff000000,
                        ),
                      ),
                    ),
                    Text(
                      'На сумму 650Р',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(
                          0xff000000,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 49,
              right: 104,
            ),
            child: Column(
              children: [
                Text(
                  'Отправить квитанцию',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(
                      0xff0000000,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'yarinmaru@gmail.com',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3,
          ),
          SizedBox(
            height: 19,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 21,
            ),
            decoration: BoxDecoration(
              color: Color(
                0xffffffff,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  color: Color(0xff000000).withOpacity(0.1),
                ),
              ],
            ),
            height: 48,
            alignment: Alignment.center,
            child: Row(
              children: [
                Image.asset('images/mir.png'),
                Padding(
                  padding: EdgeInsets.only(left: 82, right: 35),
                  child: Text(
                    'mircard datacard cvc',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(
                        0xff0000000,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => PaymentCard()));
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 49,
                right: 30,
              ),
              child: Text(
                'Выбрать другую карту',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(
                    0xff1f63e7,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SecondStape()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 9, right: 9),
              child: Container(
                height: 33,
                color: Color(
                  0xfffedb4c,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Оплатить по карте',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(
                          0xff000000,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
