import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/checkout_page/payment_stape.dart';
import 'package:nem_pho/core/widgets/app_bar/custom_appbar.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 71,
          ),
          Padding(
            padding: EdgeInsets.only(left: 49),
            child: Text(
              'УКАЖИТЕ КАРТУ',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(
                  0xff000000,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
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
            height: 67,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentStape()));
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
                      'ВЫБРАТЬ ДАННУЮ КАРТУ',
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
