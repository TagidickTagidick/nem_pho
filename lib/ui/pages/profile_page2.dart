import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/widgets/custom_appbar.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({super.key});

  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  bool isStory = false;

  bool isExpanded = true;

  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isStory = false;
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 27,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: isStory ? Color(0xFFFFFFFF) : Color(0xFFFF451D),
                          border: Border.all(
                            color: Color(0xFFF0B0B0),
                            width: 2,
                          )
                      ),
                      child:
                      Text('Мои заказы',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isStory= true;
                      setState(() {

                      });
                    },
                    child: Container(
                      height: 27,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isStory ? Color(0xFFFF451D) : Color(0xFFFFFFFF),
                        border: Border.all(
                          color: Color(0xFFF0B0B0),
                          width: 2,
                        ),),
                      child:
                      Text('Данные',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000)
                        ),
                      ),
                    ),
                  ),
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
            ),
            child: Text('Денис',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000)
              ),),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25
            ),
            child: Text('+ 7 930 103 28 35',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)
              ),),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            height: 105,
            width: double.infinity,
            color: Color(0xFFF3F3F3),
            child: Column(
              children: [
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
                      Text('Дата заказа',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7B7A7A)
                        ),),
                      SizedBox(
                        width: 106,
                      ),
                      Text('15.09.2023',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000)
                        ),),
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
                      Text('Адрес доставки',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7B7A7A)
                        ),),
                      SizedBox(
                        width: 106,
                      ),
                      Text('Малая Московская',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000)
                        ),),
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
                      Text('Итого',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7B7A7A)
                        ),),
                      SizedBox(
                        width: 106,
                      ),
                      Text('1099,00 р',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000)
                        ),),
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
                        child: Text('Доставлен',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff)
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
                            )
                          ),
                            child: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: const Color(0xff9B8C8C)
                            ),
                      ),
                    ),
                    ),
                  ],
                ),

              ]
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Container(
            height: 136,
            width: double.infinity,
            color: Color(0xFFF3F3F3),
            child: Column(
                children: [
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
                        Text('Номер заказа',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7B7A7A)
                          ),),
                        SizedBox(
                          width: 106,
                        ),
                        Text('#23129-123',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)
                          ),),
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
                        Text('Откуда',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7B7A7A)
                          ),),
                        SizedBox(
                          width: 106,
                        ),
                        Text('Свердлова',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)
                          ),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Ваш заказ:',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF000000)
                    ),),
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
                        Text('Фо Бо',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)
                          ),),
                        SizedBox(
                          width: 106,
                        ),
                        Text('1 x 300 р',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Бун Ча',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)
                          ),),
                        SizedBox(
                          width: 106,
                        ),
                        Text('1 x 300 р',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)
                          ),),
                      ],
                    ),
                  ),
                ]
            ),
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
                Text('Стоймость товаров',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7B7A7A)
                  ),),
                SizedBox(
                  width: 106,
                ),
                Text('1099,00 р',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000)
                  ),),
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
                Text('Доставка',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7B7A7A)
                  ),),
                SizedBox(
                  width: 106,
                ),
                Text('350,00 р',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000)
                  ),),
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
                Text('Итого:',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7B7A7A)
                  ),),
                SizedBox(
                  width: 106,
                ),
                Text('1099,00 р',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000)
                  ),),
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
                  child: Text('Повторить',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff)
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
                        )
                    ),
                    child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color(0xff9B8C8C)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
