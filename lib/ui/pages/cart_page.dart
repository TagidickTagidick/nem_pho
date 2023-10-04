import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/pay/first_stape.dart';
import 'package:nem_pho/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../cart_provider.dart';
import '../../models/menu_model.dart';
import '../../models/topping_model.dart';
import '../widgets/custom_appbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    required this.cart,
    required this.toppings
  });

  final List<ProductModel> cart;
  final List<ToppingModel> toppings;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductModel> newProducts = [];
  List<ToppingModel> newToppings = [];

  List<int> counts = [];

  final TextEditingController streetController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController entranceController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isSelf = true;
  bool isTime = true;
  bool isOnline = false;

  int total = 0;

  @override
  void initState() {
    super.initState();
    List<ProductModel> oldCart = widget.cart;
    List<ToppingModel> oldToppings = widget.toppings;
    for (int i = 0; i < oldCart.length; i++) {
      total += int.parse(oldCart[i].price);
    }
    for (int i = 0; i < oldToppings.length; i++) {
      total += int.parse(oldToppings[i].price);
    }
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
    if (oldToppings.isNotEmpty) {
      oldToppings.sort((a, b) => a.title.compareTo(b.title));
      if (oldToppings.length == 1) {
        newToppings.add(oldToppings[0]);
        counts.add(1);
      } else {
        int count = 0;
        for (int i = 1; i < oldToppings.length; i++) {
          count++;
          if (oldToppings[i].title != oldToppings[i - 1].title) {
            newToppings.add(oldToppings[i - 1]);
            counts.add(count);
            count = 0;
          }
        }
        count++;
        newToppings.add(oldToppings[oldToppings.length - 1]);
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
                  for (int i = 0; i < newProducts.length; i++)
                    Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                                newProducts[i].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff000000)
                                )
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                              "${newProducts[i].price} р",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff000000)
                              )
                          ),
                          const SizedBox(width: 20),
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
                                              context.read<CartProvider>().removeProduct(newProducts[i]);
                                              total -= int.parse(newProducts[i].price);
                                              if (counts[i] == 0) {
                                                newProducts.removeAt(i);
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
                                              context.read<CartProvider>().addProduct(newProducts[i]);
                                              total += int.parse(newProducts[i].price);
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
                          ),
                          const SizedBox(width: 20)
                        ]
                    ),
                  for (int i = 0; i < newToppings.length; i++)
                    Row(
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                                newToppings[i].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Color(0xff000000)
                                )
                            )
                          ),
                          const SizedBox(width: 20),
                          Text(
                              "${newToppings[i].price} р",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff000000)
                              )
                          ),
                          const SizedBox(width: 20),
                          Container(
                              width: 120,
                              margin: const EdgeInsets.symmetric(vertical: 17),
                              child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                            onTap: () {
                                              counts[newProducts.length + i]--;
                                              context.read<CartProvider>().removeTopping(newToppings[i]);
                                              total -= int.parse(newToppings[i].price);
                                              if (counts[newProducts.length + i] == 0) {
                                                newToppings.removeAt(i);
                                                counts.removeAt(newProducts.length + i);
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
                                                    border: Border.all(
                                                        color: const Color(0xff000000)
                                                    )
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
                                              counts[newProducts.length + i]++;
                                              context.read<CartProvider>().addTopping(newToppings[i]);
                                              total += int.parse(newToppings[i].price);
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
                                                counts[newProducts.length + i].toString(),
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
                          ),
                          const SizedBox(width: 20),
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
                                          color: const Color(0xffffffff),
                                          borderRadius: BorderRadius.circular(200),
                                        border:  Border.all(
                                            color: const Color(0xffF0B0B0)
                                        )
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
                                              color: const Color(0xffFF451D),
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
                                                          ? const Color(0xff000000)
                                                          : const Color(0xffffffff)
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
                                                          ? const Color(0xffffffff)
                                                          : const Color(0xff000000)
                                                  )
                                              )
                                          )
                                        ]
                                    )
                                  )
                                ]
                            ),
                            const SizedBox(height: 18),
                            CustomTextField(
                              controller: streetController,
                                hintText: "Например: улица Мира, 1"
                            ),
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
                            CustomTextField(
                              controller: apartmentController,
                                hintText: "№ квартиры /офиса"
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: entranceController,
                                      hintText: "Подъезд"
                                  )
                                ),
                                SizedBox(width: 19),
                                Expanded(
                                    child: CustomTextField(
                                      controller: floorController,
                                        hintText: "Этаж"
                                    )
                                )
                              ]
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: phoneController,
                                hintText: "Номер телефона"
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: nameController,
                                hintText: "Введите ваше имя"
                            ),
                            const SizedBox(height: 24),
                            Stack(
                                children: [
                                  Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width - 40,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          borderRadius: BorderRadius.circular(200),
                                        border: Border.all(
                                          color: Color(0xffF0B0B0)
                                        )
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
                                              color: const Color(0xffFF451D),
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
                                                            ? const Color(0xff000000)
                                                            : const Color(0xffFFFFFF)
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
                                                            ? const Color(0xffFFFFFF)
                                                            : const Color(0xff000000)
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
                                controller: commentController,
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
                                          color: const Color(0xffffffff),
                                          borderRadius: BorderRadius.circular(200),
                                        border: Border.all(
                                            color: const Color(0xffF0B0B0)
                                        )
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
                                              color: const Color(0xffFF451D),
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
                                                          ? const Color(0xff000000)
                                                          : const Color(0xffFFFFFF)
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
                                                          ? const Color(0xffFFFFFF)
                                                          : const Color(0xff000000)
                                                  )
                                              )
                                          )
                                        ]
                                    ),
                                  )
                                ]
                            ),
                            const SizedBox(height: 31),
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
                            GestureDetector(
                              onTap: () {
                                List<Map<String, dynamic>> productMaps = newProducts.map((product) =>
                                {
                                  "title": product.title,
                                  "text": product.text,
                                  "image": product.image,
                                  "price": product.price,
                                  "is_active": product.isActive ? 1 : 0,
                                  "gramm": product.gramm,
                                }
                                ).toList();
                                List<Map<String, dynamic>> toppingMaps = newToppings.map((topping) =>
                                {
                                  "title": topping.title,
                                  "image": topping.image,
                                  "price": topping.price,
                                }
                                ).toList();
                                FirebaseDatabase.instance
                                    .ref()
                                    .child("orders/${DateTime.now().millisecondsSinceEpoch}")
                                    .update({
                                  "name": nameController.text,
                                  "adress": '${streetController.text} ${apartmentController.text} ${entranceController.text} ${floorController.text}',
                                  "comment": commentController.text,
                                  "phone": phoneController.text,
                                  "products": productMaps,
                                  "toppings": toppingMaps,
                                  "total": total,
                                  "status": "Новый"
                                });
                              },
                              child: Opacity(
                                  opacity: total > 0 ? 1 : 0.5,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstStape()));
                                  },
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
                                ),
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