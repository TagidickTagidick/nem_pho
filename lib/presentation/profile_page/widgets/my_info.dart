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
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _entranceController = TextEditingController();
  final TextEditingController _flatController = TextEditingController();
  String _dateOfBirth = '';
  bool? _sex;

  bool get canSave {
    final user = context.read<ProfileProvider>().user;
    if (user == null) return false;

    final bool nameChanged = _nameController.text != (user.name ?? '');
    final bool birthdayChange = _dateOfBirth != (user.birthday == null ? '' : Formatter.convertDateOfBirth(user.birthday!));
    final bool streetChange = _streetController.text != (user.street ?? '');

    final int floorNumber = _floorController.text.isEmpty ? 0 : int.parse(_floorController.text);
    final bool floorChange = floorNumber != (user.floor ?? 0);

    final int entranceNumber = _entranceController.text.isEmpty ? 0 : int.parse(_entranceController.text);
    final bool entranceChange = entranceNumber != (user.entrance ?? 0);

    final int flatNumber = _flatController.text.isEmpty ? 0 : int.parse(_flatController.text);
    final bool flatChange = flatNumber != (user.flat ?? 0);

    final bool buildingChange = _buildingController.text != (user.building ?? '');
    final bool sexChange = Formatter.convertSex(_sex) != (user.sex ?? 'Не выбрано');

    return nameChanged || birthdayChange
        || sexChange || streetChange
        || floorChange || buildingChange
        || entranceChange || flatChange;
  }

  @override
  void initState() {
    _initFields();
    _initListeners();
    super.initState();
  }

  void _initFields() {
    final user = context.read<ProfileProvider>().user;
    if (user == null) return;
    _nameController.text = user.name ?? "";
    _streetController.text = user.street ?? '';
    _buildingController.text = user.building ?? '';
    _dateOfBirth = user.birthday == null ? '' : Formatter.convertDateOfBirth(user.birthday!);
    _sex = user.sex == null ? null : (user.sex == 'Мужской');
    _floorController.text = user.floor == null ? '' : user.floor.toString();
    _entranceController.text = user.entrance == null ? '' : user.entrance.toString();
    _flatController.text = user.flat == null ? '' : user.flat.toString();
  }

  void _initListeners() {
    _nameController.addListener(() {
      setState(() {});
    });
    _streetController.addListener(() {
      setState(() {});
    });
    _floorController.addListener(() {
      setState(() {});
    });
    _buildingController.addListener((){
      setState(() {

      });
    });
    _entranceController.addListener((){
      setState(() {

      });
    });
    _flatController.addListener((){
      setState(() {

      });
    });

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
              'Дом',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)
              ),
            ),
          ),
          const SizedBox(height: 2),
          CustomTextField(
            textEditingController: _buildingController,
            isNumber: false,
          ),
          SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Подъезд',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF808080)
              ),
            ),
          ),
          const SizedBox(height: 2),
          CustomTextField(
            textEditingController: _entranceController,
            isNumber: true,
          ),
          SizedBox(height: 16),
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
                  street: _streetController.text.isEmpty ? null : _streetController.text,
                  floor: _floorController.text.isEmpty ? null : int.parse(_floorController.text),
                  building: _buildingController.text.isEmpty ? null : _buildingController.text,
                  entrance: _entranceController.text.isEmpty ? null : int.parse(_entranceController.text),
                  flat: _flatController.text.isEmpty ? null : int.parse(_flatController.text)
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