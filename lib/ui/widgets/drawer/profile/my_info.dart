import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/user_model.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

bool isStory = false;

bool isExpanded = true;

class _MyInfoState extends State<MyInfo> {
  late final UserModel userModel;

  bool isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  String _dateOfBirth = '';
  bool? _sex;

  void _showDialog(Widget child, bool isSex) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 302,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
            color: Color(0xffF3F3F3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
        child: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: child,
                ),
                Material(
                  child: GestureDetector(
                    onTap: () {
                      if (isSex) {
                        FirebaseDatabase.instance
                            .ref()
                            .child("users/${userModel.phone}")
                            .update({
                          "sex": _sex,
                        });
                      } else {
                        FirebaseDatabase.instance
                            .ref()
                            .child("users/${userModel.phone}")
                            .update({
                          "date_of_birth": _dateOfBirth,
                        });
                      }
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      color: const Color(0xffFFB627),
                      alignment: Alignment.center,
                      child: const Text(
                        "Сохранить",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xFF000000)),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

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
    _nameController.text = userModel.name;
    _dateOfBirth = userModel.dateOfBirth;
    _sex = userModel.sex;
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
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                ),
                child: Text(
                  'Имя',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              _buildTextField(
                controller: _nameController,
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                ),
                child: Text(
                  'Дата рождение',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              GestureDetector(
                onTap: () {
                  _dateOfBirth =
                      '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
                  _showDialog(
                    CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newDate) {
                        _dateOfBirth =
                            '${newDate.day}.${newDate.month}.${newDate.year}';
                      },
                    ),
                    false,
                  );
                },
                child: Container(
                  height: 61,
                  width: double.infinity,
                  color: Color(0xffF3F3F3),
                  child: Container(
                    height: 60,
                    color: const Color(0xffF3F3F3),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      _dateOfBirth,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff000000)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                ),
                child: Text(
                  'Пол',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF808080)),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              GestureDetector(
                onTap: () {
                  _sex = true;
                  _showDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 32.0,
                      // This sets the initial item.
                      scrollController: FixedExtentScrollController(
                        initialItem: 0,
                      ),
                      onSelectedItemChanged: (int selectedItem) {
                        switch (selectedItem) {
                          case 0:
                            _sex = true;
                            break;
                          case 1:
                            _sex = false;
                            break;
                          case 2:
                            _sex = null;
                            break;
                        }
                      },
                      children: const [
                        Center(
                            child: Text(
                          "Мужской",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff000000)),
                        )),
                        Center(
                          child: Text(
                            "Женский",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff000000)),
                          ),
                        ),
                      ],
                    ),
                    true,
                  );
                },
                child: Container(
                  height: 60,
                  color: const Color(0xffF3F3F3),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    switch (_sex) {
                      true => 'Мужской',
                      false => 'Женский',
                      null => 'Не выбрано',
                    },
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xff000000)),
                  ),
                ),
              ),
            ],
          );
  }
}

Widget _buildTextField({
  required TextEditingController controller,
}) {
  return Container(
    height: 60,
    color: Color(0xffF3F3F3),
    child: TextField(
      controller: controller,
      style: const TextStyle(
          fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xff000000)),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ),
  );
}
