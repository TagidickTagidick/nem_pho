import 'package:flutter/material.dart';

class DeliveryInfoPage extends StatelessWidget {
  const DeliveryInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffffffff),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
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
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      Text(
                        "Условия доставки",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 48,
                                width: 139,
                                child: Text(
                                  'Принимаем заказы',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                height: 76,
                                width: 139,
                                color: Color(0xffF6F6F6),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      'с 11:00 до 21:00',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Container(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 48,
                                width: 139,
                                child: Text(
                                  'Минимальная сумма',
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                height: 76,
                                width: 139,
                                color: Color(0xffF6F6F6),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      '500 ₽',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 48,
                              width: 139,
                              child: Text(
                                'Стоимость доставки',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              height: 76,
                              width: 139,
                              color: Color(0xffF6F6F6),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    'Бесплатно',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),

                // Middle Page content
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      // "Delivery Time" Plate
                      Container(
                        color: Color(0xffF6F6F6),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 40,
                                child: Icon(
                                  Icons.history
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Время доставки',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width * 0.7,
                                    child: const Text(
                                      'По Ярославлю - 45 минут, по остальной территории - не доставляем',
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // maxLines: 2,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // "Delivery by courer" Plate
                      Container(
                        color: Color(0xffF6F6F6),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              // Image.asset(Icon(), width: 40),
                              SizedBox(
                                width: 40,
                                child: Icon(
                                  Icons.motorcycle
                              ),
                                // child: Icon(MorePageIcons.car, size: 25,)
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Доставка курьером',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width * 0.7,
                                    child: const Text(
                                      'Вы оплачиваете только заказ, доставка - бесплатная',
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      // "Take away with 10% discount" Plate
                      Container(
                        color: Color(0xffF6F6F6),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: Icon(
                                    Icons.shopping_bag
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'С собой со скидкой 10%',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width * 0.7,
                                    child: const Text(
                                      '''Вы можете сами забрать заказ из ближайшего ресторана со скидкой в 10%.
Время приготовления заказа - 15 минут.
        
*скидки не распространяются на раздел меню “Напитки”''',
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // maxLines: 2,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

