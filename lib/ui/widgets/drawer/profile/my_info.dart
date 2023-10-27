import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

bool isStory = false;

bool isExpanded = true;

class _MyInfoState extends State<MyInfo> {
  TextEditingController _textNameController = TextEditingController();
  TextEditingController _textBirthController = TextEditingController();
  TextEditingController _textSexController = TextEditingController();

  DateTime date = DateTime(2016, 10, 26);

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 302,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
            color: Color(0xffF3F3F3),
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(40)
            )
        ),
        child: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: child,
                ),
                Material(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      color: Color(0xffFFB627),
                      alignment: Alignment.center,
                      child: Text(
                        "Сохранить",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Color(0xFF000000)
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Text('Имя',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080)
            ),),
        ),
        SizedBox(
          height: 2,
        ),
        _buildTextField(
          controller: _textNameController,
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 18,
          ),
          child: Text('Дата рождение',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080)
            ),),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: 61,
          width: double.infinity,
          color: Color(0xffF3F3F3),
          child: TextField(
            onTap: () {
              setState(() {
                _textBirthController.text = '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
              });
              _showDialog(
                CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  // This is called when the user changes the date.
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => _textBirthController.text = '${newDate.day}.${newDate.month}.${newDate.year}');
                  },
                ),
              );
            },
            controller: _textBirthController,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xff000000)
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
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
          child: Text('Пол',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080)
            ),),
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: 60,
          color: Color(0xffF3F3F3),
          child: TextField(
            onTap: () {
              setState(() {
                _textSexController.text = "Мужской";
              });
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
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    switch (selectedItem) {
                      case 0:
                        _textSexController.text = "Мужской";
                        break;
                      case 1:
                        _textSexController.text = "Женский";
                        break;
                      case 2:
                        _textSexController.text = "Не выбрано";
                        break;
                    }
                    setState(() {});
                  },
                  children: [
                    Center(
                        child: Text(
                          "Мужской",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff000000)
                          ),
                        )
                    ),
                    Center(
                      child: Text(
                        "Женский",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff000000)
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            controller: _textSexController,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xff000000)
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
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
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xff000000)
      ),
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