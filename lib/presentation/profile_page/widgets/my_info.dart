import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/profile_page/profile_provider/profile_provider.dart';
import 'package:nem_pho/presentation/profile_page/widgets/custom_text_field.dart';
import 'package:nem_pho/presentation/profile_page/widgets/save_button.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/services/sheet_service.dart';
import 'package:nem_pho/core/utils/formatter.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  String _dateOfBirth = '';
  bool? _sex;

  bool get canSave {
    final user = context.read<ProfileProvider>().user;
    if (user == null) return false;
    final bool nameChanged = _nameController.text != user.name;
    final bool birthdayChange = _dateOfBirth != user.birthday;
    final bool streetChange = _streetController.text != user.street;
    final bool floorChange = int.parse(_floorController.text) != user.floor;
    final bool sexChange = Formatter.convertSex(_sex) != (user.sex ?? 'Не выбрано');
    return nameChanged || birthdayChange || sexChange || streetChange || floorChange;
  }

  @override
  void initState() {
    _nameController.text = context.read<ProfileProvider>().user?.name ?? "";
    _nameController.addListener(() {
      setState(() {});
    });
    _streetController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Имя',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)),
            ),
          ),
          const SizedBox(height: 2),
          CustomTextField(textEditingController: _nameController),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Дата рождения',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)
              ),
            ),
          ),
          const SizedBox(height: 2),
          GestureDetector(onTap: () {
            _dateOfBirth =
            '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
            SheetService.showDatePicker(
                context,
                onChanged: (newDate) {
                  _dateOfBirth =
                  '${newDate.day}.${newDate.month}.${newDate.year}';
                  print(newDate.month);
                  setState(() {});
                }
            );
          },
            child: Container(
              height: 61,
              width: double.infinity,
              color: const Color(0xffF3F3F3),
              child: Container(
                height: 60,
                color: const Color(0xffF3F3F3),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  _dateOfBirth,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff000000)
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Пол',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)
              ),
            ),
          ),
          const SizedBox(height: 2),
          GestureDetector(onTap: () {
            _sex = true;
            SheetService.showPicker(
              context,
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
                setState(() {});
              },
            );
          },
            child: Container(
              height: 60,
              color: const Color(0xffF3F3F3),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                Formatter.convertSex(_sex),
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff000000)
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Улица',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)
              ),
            ),
          ),
          const SizedBox(height: 2),
          CustomTextField(textEditingController: _streetController),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Этаж',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)
              ),
            ),
          ),
          const SizedBox(height: 2),
          CustomTextField(
              textEditingController: _floorController,
            isNumber: true,
          ),
          const SizedBox(height: 100),
          if (canSave)
            GestureDetector(onTap: () {
              context.read<ProfileProvider>().save(
                  birthday: _dateOfBirth.isEmpty ? null : _dateOfBirth.replaceAll('.', '-'),
                  name: _nameController.text.isEmpty ? null : _nameController.text,
                  sex: Formatter.convertSex(_sex),
                  street: _streetController.text.isEmpty ? null : _streetController.text
              );
            },
                child: const SaveButton()
            ),
          const SizedBox(height: 100),
          Center(
            child: GestureDetector(onTap: () {
              SheetService.showSheet(
                  context,
                  onTap:() {
                    context.read<ProfileProvider>().deleteUser();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
              );
            },
              child: const Text(
                'Удалить аккаунт',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF808080)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}