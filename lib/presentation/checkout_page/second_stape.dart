import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/checkout_page/cancel_stape.dart';
import 'package:nem_pho/core/widgets/app_bar/custom_appbar.dart';
import 'package:nem_pho/presentation/checkout_page/payment_divider.dart';
import 'package:nem_pho/presentation/checkout_page/payment_dot.dart';

class SecondStape extends StatefulWidget {
  const SecondStape({Key? key}) : super(key: key);

  @override
  State<SecondStape> createState() => _SecondStapeState();
}

class _SecondStapeState extends State<SecondStape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            "СТАТУС ЗАКАЗА",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(
                0xff000000,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: Color(0xffd9d9d9),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 19,
                  width: 19,
                  decoration: BoxDecoration(
                    color: Color(0xffff451d),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              PaymentDivider(),
              Container(
                alignment: Alignment.center,
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: Color(0xffd9d9d9),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 19,
                  width: 19,
                  decoration: BoxDecoration(
                    color: Color(0xffff451d),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              PaymentDivider(),
              PaymentDot(),
              PaymentDivider(),
              PaymentDot(),
            ],
          ),
          SizedBox(
            height: 28,
          ),
          Container(
            height: 95,
            color: Color(0xffd9d9d9).withOpacity(0.27),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ГОТОВИМ ВАШ ЗАКАЗ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
                Text(
                  "ВАШ ЗАКАЗ ПРИНЯТ В РАБОТУ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Text(
            "ВАШ ЗАКАЗ",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(
                0xff000000,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 47,
              right: 35,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ФО БО",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
                Text(
                  "1*300 Р",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 47,
              right: 35,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "БУН ЧА",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
                Text(
                  "1*350 Р",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CancelStape()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 9, right: 9),
              child: Container(
                height: 33,
                color: Color(
                  0xffF9C2BA,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ОТМЕНИТЬ ЗАКАЗ',
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
