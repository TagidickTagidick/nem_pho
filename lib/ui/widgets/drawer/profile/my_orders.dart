import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/user_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool isExpanded = true;

  late AnimationController _controller;

  late final UserModel userModel;

  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    final snapshot = await FirebaseDatabase.instance
        .ref("users/${prefs.getString('phone')}")
        .get();
    userModel = UserModel.fromJson(snapshot.value as Map);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: Text(
                  userModel.name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000)),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  userModel.phone,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080)),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: userModel.orders.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        height: 105,
                        width: double.infinity,
                        color: Color(0xFFF3F3F3),
                        child: Column(children: [
                          SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Дата заказа',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7B7A7A)),
                                ),
                                SizedBox(
                                  width: 106,
                                ),
                                Text(
                                  userModel.orders[index].date,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF000000)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Адрес доставки',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7B7A7A)),
                                ),
                                SizedBox(
                                  width: 106,
                                ),
                                Text(
                                  userModel.orders[index].adress,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF000000)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Итого',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7B7A7A)),
                                ),
                                SizedBox(
                                  width: 106,
                                ),
                                Text(
                                  '${userModel.orders[index].total} р',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF000000)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  alignment: Alignment.center,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffff9900),
                                  ),
                                  child: Text(
                                    userModel.orders[index].status,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffffffff)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (isExpanded) {
                                    _controller.reverse();
                                  } else {
                                    _controller.forward();
                                  }
                                  isExpanded = !isExpanded;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 30,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 20,
                                    width: 41,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xFFFFFFFF),
                                        border: Border.all(
                                          color: Color(0xfff0b0b0),
                                          width: 2,
                                        )),
                                    child: Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: const Color(0xff9B8C8C)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Container(
                        height: 136,
                        width: double.infinity,
                        color: Color(0xFFF3F3F3),
                        child: Column(children: [
                          SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              right: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Номер заказа',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF7B7A7A)),
                                ),
                                SizedBox(
                                  width: 106,
                                ),
                                Text(
                                  userModel.orders[index].id.toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF000000)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Ваш заказ:',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF000000)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [],
                          ),
                          for (int i = 0;
                              i < userModel.orders[index].products.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25,
                                right: 25,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userModel.orders[index].products[i].title,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF000000)),
                                  ),
                                  SizedBox(
                                    width: 106,
                                  ),
                                  Text(
                                    '${userModel.orders[index].products[i].price} р',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF000000)),
                                  ),
                                ],
                              ),
                            ),
                          for (int i = 0;
                              i < userModel.orders[index].toppings.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 25,
                                right: 25,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userModel.orders[index].toppings[i].title,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF000000)),
                                  ),
                                  SizedBox(
                                    width: 106,
                                  ),
                                  Text(
                                    '${userModel.orders[index].toppings[i].price} р',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF000000)),
                                  ),
                                ],
                              ),
                            ),
                        ]),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Стоймость товаров',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7B7A7A)),
                            ),
                            SizedBox(
                              width: 106,
                            ),
                            Text(
                              '${userModel.orders[index].total} р',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Доставка',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7B7A7A)),
                            ),
                            SizedBox(
                              width: 106,
                            ),
                            Text(
                              '${userModel.orders[index].delivery} р',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Итого:',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7B7A7A)),
                            ),
                            SizedBox(
                              width: 106,
                            ),
                            Text(
                              '${userModel.orders[index].total + userModel.orders[index].delivery} р',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000000)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage3()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                alignment: Alignment.center,
                                height: 24,
                                width: 173,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffFF451D),
                                ),
                                child: Text(
                                  'Повторить',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffffffff)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isExpanded) {
                                _controller.reverse();
                              } else {
                                _controller.forward();
                              }
                              isExpanded = !isExpanded;
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 41,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFFFFFFF),
                                    border: Border.all(
                                      color: Color(0xfff0b0b0),
                                      width: 2,
                                    )),
                                child: Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: const Color(0xff9B8C8C)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
