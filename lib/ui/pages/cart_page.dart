import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';
import '../../models/menu_model.dart';
import '../widgets/custom_appbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cart});

  final List<ProductModel> cart;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductModel> newCart = [];
  List<int> counts = [];

  bool isSelf = true;
  bool isTime = true;
  bool isOnline = false;

  int total = 0;

  @override
  void initState() {
    super.initState();
    List<ProductModel> oldCart = widget.cart;
    for (int i = 0; i < oldCart.length; i++) {
      total += int.parse(oldCart[i].price);
    }
    if (oldCart.isNotEmpty) {
      oldCart.sort((a, b) => a.title.compareTo(b.title));
      if (oldCart.length == 1) {
        newCart = [oldCart[0]];
        counts = [1];
      } else {
        int count = 0;
        for (int i = 1; i < oldCart.length; i++) {
          count++;
          if (oldCart[i].title != oldCart[i - 1].title) {
            newCart.add(oldCart[i - 1]);
            counts.add(count);
            count = 0;
          }
        }
        count++;
        newCart.add(oldCart[oldCart.length - 1]);
        counts.add(count);
      }
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child: Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar()
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 28,
                          bottom: 7
                      ),
                      child: Text(
                          "Корзина",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Color(0xff000000)
                          )
                      )
                  ),
                  for (int i = 0; i < newCart.length; i++)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              newCart[i].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff000000)
                              )
                          ),
                          Text(
                              "${newCart[i].price} р",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff000000)
                              )
                          ),
                          Container(
                              width: 120,
                              margin: const EdgeInsets.symmetric(vertical: 17),
                              child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                            onTap: () {
                                              counts[i]--;
                                              context.read<CartProvider>().removeProduct(newCart[i]);
                                              total -= int.parse(newCart[i].price);
                                              if (counts[i] == 0) {
                                                newCart.removeAt(i);
                                                counts.removeAt(i);
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                                height: 37,
                                                width: 60,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(37),
                                                        bottomLeft: Radius.circular(37)
                                                    ),
                                                    border: Border.all(color: const Color(0xff000000))
                                                ),
                                                child: const Icon(
                                                    Icons.remove,
                                                    color: Color(0xff000000)
                                                )
                                            )
                                        )
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                            onTap: () {
                                              counts[i]++;
                                              context.read<CartProvider>().addProduct(newCart[i]);
                                              total += int.parse(newCart[i].price);
                                              setState(() {});
                                            },
                                            child: Container(
                                                height: 37,
                                                width: 60,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(
                                                        topRight: Radius.circular(37),
                                                        bottomRight: Radius.circular(37)
                                                    ),
                                                    border: Border.all(color: const Color(0xff000000))
                                                ),
                                                child: const Icon(
                                                    Icons.add,
                                                    color: Color(0xff000000)
                                                )
                                            )
                                        )
                                    ),
                                    Center(
                                        child: Container(
                                            height: 38,
                                            width: 38,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffFF451D)
                                            ),
                                            child: Text(
                                                counts[i].toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 24,
                                                    color: Color(0xffFFFFFF)
                                                )
                                            )
                                        )
                                    )
                                  ]
                              )
                          )
                        ]
                    ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 15,
                          left: 14,
                          right: 6
                      ),
                      padding: const EdgeInsets.only(
                          top: 20,
                          left: 17,
                          right: 16
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xffF6F6F6),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                          children: [
                            Row(
                                children: const [
                                  Text(
                                      "Доставка: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Color(0xff000000)
                                      )
                                  ),
                                  Text(
                                      "Ярославль",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Color(0xff000000)
                                      )
                                  )
                                ]
                            ),
                            const SizedBox(height: 10),
                            Stack(
                                children: [
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width - 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF451D),
                                          borderRadius: BorderRadius.circular(200)
                                      )
                                  ),
                                  AnimatedAlign(
                                      alignment: isSelf
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      duration: const Duration(milliseconds: 200),
                                      child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          height: 40,
                                          width: MediaQuery.of(context).size.width / 2.25,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFFFFFF),
                                              borderRadius: BorderRadius.circular(200),
                                              border: Border.all(
                                                  color: const Color(0xffF0B0B0)
                                              )
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () => setState(() => isSelf = false),
                                              child: Text(
                                                  "Доставка на дом",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      color: isSelf
                                                          ? const Color(0xffFFFFFF)
                                                          : const Color(0xff000000)
                                                  )
                                              )
                                          ),
                                          GestureDetector(
                                              onTap: () => setState(() => isSelf = true),
                                              child: Text(
                                                  "Забрать самому",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      color: isSelf
                                                          ? const Color(0xff000000)
                                                          : const Color(0xffFFFFFF)
                                                  )
                                              )
                                          )
                                        ]
                                    )
                                  )
                                ]
                            ),
                            const SizedBox(height: 18),
                            const CustomTextField(hintText: "Например: улица Мира, 1"),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                    Icons.location_on,
                                  color: Color(0xff000000)
                                ),
                                Text(
                                  "Указать на карте",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: const Color(0xff000000).withOpacity(0.42)
                                  )
                                )
                              ]
                            ),
                            const SizedBox(height: 10),
                            const CustomTextField(hintText: "№ квартиры /офиса"),
                            const SizedBox(height: 18),
                            Row(
                              children: const [
                                Expanded(
                                  child: CustomTextField(
                                      hintText: "Подъезд"
                                  )
                                ),
                                SizedBox(width: 19),
                                Expanded(
                                    child: CustomTextField(
                                        hintText: "Этаж"
                                    )
                                )
                              ]
                            ),
                            const SizedBox(height: 24),
                            const CustomTextField(hintText: "Номер телефона"),
                            const SizedBox(height: 24),
                            const CustomTextField(hintText: "Введите ваше имя"),
                            const SizedBox(height: 24),
                            Stack(
                                children: [
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width - 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF451D),
                                          borderRadius: BorderRadius.circular(200)
                                      )
                                  ),
                                  AnimatedAlign(
                                      alignment: isTime
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      duration: const Duration(milliseconds: 200),
                                      child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          height: 40,
                                          width: MediaQuery.of(context).size.width / (isTime
                                              ? 3
                                              : 2),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFFFFFF),
                                              borderRadius: BorderRadius.circular(200),
                                              border: Border.all(
                                                  color: const Color(0xffF0B0B0)
                                              )
                                          )
                                      )
                                  ),
                                  SizedBox(
                                      height: 40,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                onTap: () => setState(() => isTime = false),
                                                child: Text(
                                                    "Как можно быстрее",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        color: isTime
                                                            ? const Color(0xffFFFFFF)
                                                            : const Color(0xff000000)
                                                    )
                                                )
                                            ),
                                            GestureDetector(
                                                onTap: () => setState(() => isTime = true),
                                                child: Text(
                                                    "Ко времени",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        color: isTime
                                                            ? const Color(0xff000000)
                                                            : const Color(0xffFFFFFF)
                                                    )
                                                )
                                            )
                                          ]
                                      )
                                  )
                                ]
                            ),
                            const SizedBox(height: 24),
                            Container(
                              height: 77,
                                padding: const EdgeInsets.only(
                                    left: 22
                                ),
                                decoration: BoxDecoration(
                                    color: const Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(200),
                                    border: Border.all(
                                        color: const Color(0xffF0B0B0)
                                    )
                                ),
                                child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Комментарий курьеру",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: const Color(0xff000000).withOpacity(0.42)
                                        )
                                    )
                                )
                            ),
                            const SizedBox(height: 48)
                          ]
                      )
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                          top: 31,
                          left: 29,
                          bottom: 4
                      ),
                      child: Text(
                          "Оплата",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20
                          )
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10,
                          left: 40,
                          right: 40,
                          bottom: 20
                      ),
                      child: Column(
                          children: [
                            Stack(
                                children: [
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width - 80,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF451D),
                                          borderRadius: BorderRadius.circular(200)
                                      )
                                  ),
                                  AnimatedAlign(
                                      alignment: isOnline
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      duration: const Duration(milliseconds: 200),
                                      child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          height: 40,
                                          width: MediaQuery.of(context).size.width / (isOnline
                                              ? 3
                                              : 2),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFFFFFF),
                                              borderRadius: BorderRadius.circular(200),
                                              border: Border.all(
                                                  color: const Color(0xffF0B0B0)
                                              )
                                          )
                                      )
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () => setState(() => isOnline = false),
                                              child: Text(
                                                  "Наличными",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      color: isOnline
                                                          ? const Color(0xffFFFFFF)
                                                          : const Color(0xff000000)
                                                  )
                                              )
                                          ),
                                          GestureDetector(
                                              onTap: () => setState(() => isOnline = true),
                                              child: Text(
                                                  "Онлайн",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      color: isOnline
                                                          ? const Color(0xff000000)
                                                          : const Color(0xffFFFFFF)
                                                  )
                                              )
                                          )
                                        ]
                                    ),
                                  )
                                ]
                            ),
                            const SizedBox(height: 31),
                            Container(
                              height: 29,
                              padding: const EdgeInsets.only(
                                  top: 7.25,
                                  left: 36
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(
                                      color: const Color(0xffF0B0B0)
                                  )
                              ),
                              child: const TextField(
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(7.98),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w100,
                                        color: Color(0xff000000)
                                    )
                                )
                              )
                            ),
                            const SizedBox(height: 18),
                            Stack(
                                children: [
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width - 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF451D),
                                          borderRadius: BorderRadius.circular(200)
                                      )
                                  ),
                                  AnimatedAlign(
                                      alignment: isSelf
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      duration: const Duration(milliseconds: 200),
                                      child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          height: 40,
                                          width: MediaQuery.of(context).size.width / 2.25,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffFFFFFF),
                                              borderRadius: BorderRadius.circular(200),
                                              border: Border.all(
                                                  color: const Color(0xffF0B0B0)
                                              )
                                          )
                                      )
                                  ),
                                  SizedBox(
                                      height: 40,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                onTap: () => setState(() => isSelf = false),
                                                child: Container(
                                                  color: Colors.transparent,
                                                  width: (MediaQuery.of(context).size.width - 80) / 2
                                                )
                                            ),
                                            GestureDetector(
                                                onTap: () => setState(() => isSelf = true),
                                                child: Container(
                                                    color: Colors.transparent,
                                                    width: (MediaQuery.of(context).size.width - 80) / 2
                                                )
                                            )
                                          ]
                                      )
                                  )
                                ]
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              "Соглашаюсь на распространение указанных в заказе персональных данных третьим лицам. С условиями Публичной оферты ознакомлен.",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 9,
                                color: Color(0xff000000)
                              )
                            ),
                            const SizedBox(height: 12),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                      "Доставка",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(0xff000000)
                                      )
                                  ),
                                  Text(
                                      "Бесплатно",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 12,
                                          color: Color(0xff000000)
                                      )
                                  )
                                ]
                            ),
                            const SizedBox(height: 127),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      "К оплате:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Color(0xff000000)
                                      )
                                  ),
                                  Text(
                                      "$totalр",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Color(0xff000000)
                                      )
                                  )
                                ]
                            ),
                            const SizedBox(height: 9),
                            Opacity(
                                opacity: total > 0 ? 1 : 0.5,
                              child: Container(
                                  height: 29,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff19B80B),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: const Text(
                                      "Оформить заказ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF)
                                      )
                                  )
                              ),
                            )
                          ]
                      )
                  )
                ]
            )
        )
    )
  );
}