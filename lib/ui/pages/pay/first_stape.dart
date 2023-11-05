import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/models/product_model.dart';
import 'package:nem_pho/ui/widgets/custom/custom_appbar.dart';
import 'package:nem_pho/ui/widgets/pay/payment_divider.dart';
import 'package:nem_pho/ui/widgets/pay/payment_dot.dart';
import 'package:provider/provider.dart';

import '../../../cart_provider.dart';
import '../../widgets/pay/payment_dot_enabled.dart';

class FirstStape extends StatefulWidget {
  const FirstStape({Key? key, required this.street, required this.apartment, required this.entrance, required this.floor, required this.name, required this.phone, required this.comment, required this.total, required this.delivery, required this.id, required this.isSelf, required this.isCash,}) : super(key: key);

  final String street;
  final String apartment;
  final String entrance;
  final String floor;
  final String name;
  final String phone;
  final String comment;
  final int total;
  final int delivery;
  final int id;
  final bool isSelf;
  final bool isCash;

  @override
  State<FirstStape> createState() => _FirstStapeState();
}

class _FirstStapeState extends State<FirstStape> {
  List<ProductModel> newProducts = [];

  List<int> counts = [];

  int id = 0;

  @override
  void initState() {
    id = widget.id;
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
      appBar: const CustomAppBar(isCart: false),
      body: StreamBuilder(
          stream: FirebaseDatabase.instance.ref("orders/$id").onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            String status = '';
            bool isSelf = false;
            if (snapshot.hasData) {
              if (snapshot.data?.snapshot.value != null) {
                Map order = snapshot.data?.snapshot.value as Map;
                status = order["status"];
                print(order["address"]);
                isSelf = order["is_self"];
              }
            }
          return Column(
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
                      0xff000000
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PaymentDotEnabled(),
                  PaymentDivider(),
                  status == "Новый" || status == "В работе" || status == "Готов" ? PaymentDotEnabled() : PaymentDot(),
                  PaymentDivider(),
                  status == "В работе" || status == "Готов" ? PaymentDotEnabled() : PaymentDot(),
                  PaymentDivider(),
                  status == "Готов" ? PaymentDotEnabled() : PaymentDot(),
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
                      switch (status) {
                        "" => "ОЖИДАЕТ ПОДТВЕРЖДЕНИЯ",
                        "Новый" => "ОЖИДАЕТ ПОДТВЕРЖДЕНИЯ",
                        "В работе" => "ГОТОВИМ ВАШ ЗАКАЗ",
                        "Готов" => isSelf ? "МЫ ПРИГОТОВИЛИ ВАШ ЗАКАЗ" : "ДОСТАВЛЕН",
                        String() => "ОЖИДАЕТ ПОДТВЕРЖДЕНИЯ",
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(
                          0xff000000,
                        ),
                      ),
                    ),
                    Text(
                      switch (status) {
                        "" => "ВАШ ЗАКАЗ ОЖИДАЕТ ПОДТВЕРЖДЕНИЯ",
                        "Новый" => "С ВАМИ В БЛИЖАЙШЕЕ ВРЕМЯ СВЯЖЕТСЯ КУРЬЕР ДЛЯ ПОДТВЕРЖДЕНИЯ ЗАКАЗА",
                        "В работе" => "ВАШ ЗАКАЗ ПРИНЯТ В РАБОТУ",
                        "Готов" => isSelf ? "ЗАБЕРИТЕ ЕГО В РЕСТОРАНЕ" : "МЫ ПРИВЕЗЛИ ВАШ ЗАКАЗ",
                        String() => "ОЖИДАЕТ",
                      },
                      textAlign: TextAlign.center,
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
                      ],
                    ),
                    SizedBox(
                      height: 16.73,
                    ),
                    id == 0
                        ? GestureDetector(
                      onTap: () {
                        List<ProductModel> cart = context.read<CartProvider>().userModel!.cart;
                        List<Map> jsonCart = [];
                        for (var product in cart) {
                          jsonCart.add(product.toJson());
                        }
                        id = DateTime.now().millisecondsSinceEpoch;
                        setState(() {});
                        FirebaseDatabase.instance
                            .ref()
                            .child(
                            "orders/$id")
                            .update({
                          "address": '${widget.street}, квартира: ${widget.apartment}, подъезд: ${widget.entrance}, этаж: ${widget.floor}',
                          "name": widget.name,
                          "phone": widget.phone.replaceAll(" ", "_"),
                          "comment": widget.comment,
                          "products": jsonCart,
                          "total": widget.total,
                          "status": "Новый",
                          "delivery": widget.delivery,
                          "is_self": widget.isSelf,
                          "is_cash": widget.isCash,
                        });
                        FirebaseDatabase.instance
                            .ref()
                            .child(
                            "users/${context.read<CartProvider>().phone}")
                            .update({
                          "name": widget.name,
                          "phone": widget.phone.replaceAll(" ", "_"),
                          "street": widget.street,
                          "apartment": widget.apartment,
                          "entrance": widget.entrance,
                          "floor": widget.floor,
                          "comment": widget.comment,
                        });
                        FirebaseDatabase.instance
                            .ref()
                            .child(
                            "users/${context.read<CartProvider>().phone}/orders/$id")
                            .update({
                          "address": '${widget.street}, квартира: ${widget.apartment}, подъезд: ${widget.entrance}, этаж: ${widget.floor}',
                          "name": widget.name,
                          "phone": widget.phone.replaceAll(" ", "_"),
                          "comment": widget.comment,
                          "products": jsonCart,
                          "total": widget.total,
                          "status": "Новый",
                          "delivery": widget.delivery,
                          "is_self": widget.isSelf,
                          "is_cash": widget.isCash,
                        });
                        context.read<CartProvider>().clearProducts();
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
                    )
                        : status == "Готов"
                        ? const SizedBox()
                        : GestureDetector(
                      onTap: () {
                        FirebaseDatabase.instance.ref("orders/$id").update({
                          "status": "Отменён"
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 49,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          color: Color(0xffF9C2BA),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "ОТМЕНИТЬ ЗАКАЗ",
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
          );
        }
      ),
    );
  }
}
