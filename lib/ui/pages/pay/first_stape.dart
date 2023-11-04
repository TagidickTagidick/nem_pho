import 'package:flutter/material.dart';
import 'package:nem_pho/models/product_model.dart';
import 'package:nem_pho/ui/pages/pay/second_stape.dart';
import 'package:nem_pho/ui/widgets/custom/custom_appbar.dart';
import 'package:nem_pho/ui/widgets/pay/payment_divider.dart';
import 'package:nem_pho/ui/widgets/pay/payment_dot.dart';
import 'package:provider/provider.dart';

import '../../../cart_provider.dart';

class FirstStape extends StatefulWidget {
  const FirstStape({Key? key}) : super(key: key);

  @override
  State<FirstStape> createState() => _FirstStapeState();
}

class _FirstStapeState extends State<FirstStape> {
  List<ProductModel> newProducts = [];

  List<int> counts = [];

  @override
  void initState() {
    List<ProductModel> oldCart = context.read<CartProvider>().userModel!.cart;
    if (oldCart.isNotEmpty) {
      oldCart.sort((a, b) => a.title.compareTo(b.title));
      if (oldCart.length == 1) {
        newProducts.add(oldCart[0]);
        counts.add(1);
      } else {
        int count = 0;
        for (int i = 1; i < oldCart.length; i++) {
          count++;
          if (oldCart[i].title != oldCart[i - 1].title) {
            newProducts.add(oldCart[i - 1]);
            counts.add(count);
            count = 0;
          }
        }
        count++;
        newProducts.add(oldCart[oldCart.length - 1]);
        counts.add(count);
      }
    }
    super.initState();
  }

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
              Paymentdot(),
              PaymentDivider(),
              Paymentdot(),
              PaymentDivider(),
              Paymentdot(),
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
                  "ОЖИДАЕТ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
                Text(
                  "ВАШ ЗАКАЗ ОЖИДАТ ПОДТВРЕРЖДЕНИЯ",
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
          for (int i = 0; i < newProducts.length; i++)
            Padding(
              padding: const EdgeInsets.only(
                left: 47,
                right: 35,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newProducts[i].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Color(
                        0xff000000,
                      ),
                    ),
                  ),
                  Text(
                    "${counts[i]}*${newProducts[i].price} р",
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
            height: 27,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffd9d9d9).withOpacity(0.27),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 47,
              right: 22,
              top: 21,
              bottom: 8,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "К оплате:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(
                          0xff000000,
                        ),
                      ),
                    ),
                    Text(
                      "650 Р",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(
                          0xff000000,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.close,
                      color: Color(
                        0xfff76666,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16.73,
                ),
                Text(
                  "C вами в ближайшее время свяжется оператор для подтверждения заказа",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Color(
                      0xff000000,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.73,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondStape()));
                  },
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Color(0xff343434),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "ПОДТВЕРДИТЬ ЗАКАЗ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(
                          0xffffffff,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
