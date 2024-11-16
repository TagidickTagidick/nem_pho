import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/profile_page/widgets/save_button.dart';

class SheetService {
  static void showPicker(BuildContext context, {required void Function(int) onSelectedItemChanged}) {
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
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(40)
            )
        ),
        child: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 32.0,
                    scrollController: FixedExtentScrollController(
                      initialItem: 0,
                    ),
                    onSelectedItemChanged: onSelectedItemChanged,
                    children: const [
                      Center(
                          child: Text(
                            "Мужской",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff000000)
                            ),
                          )),
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
                ),
                Material(
                  child: GestureDetector(
                      onTap: () {
                        // if (isSex) {
                        //   FirebaseDatabase.instance
                        //       .ref()
                        //       .child("users/${userModel.phone}")
                        //       .update({
                        //     "sex": _sex,
                        //   });
                        // } else {
                        //   FirebaseDatabase.instance
                        //       .ref()
                        //       .child("users/${userModel.phone}")
                        //       .update({
                        //     "date_of_birth": _dateOfBirth,
                        //   });
                        // }
                        // setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const SaveButton()
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  static void showDatePicker(BuildContext context, {required void Function(DateTime) onChanged}) {
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
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    onDateTimeChanged: onChanged,
                  ),
                ),
                Material(
                  child: GestureDetector(
                      onTap: () {
                        // if (isSex) {
                        //   FirebaseDatabase.instance
                        //       .ref()
                        //       .child("users/${userModel.phone}")
                        //       .update({
                        //     "sex": _sex,
                        //   });
                        // } else {
                        //   FirebaseDatabase.instance
                        //       .ref()
                        //       .child("users/${userModel.phone}")
                        //       .update({
                        //     "date_of_birth": _dateOfBirth,
                        //   });
                        // }
                        // setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: const SaveButton()
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  static void showSheet(BuildContext context, {required void Function() onTap}) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 46),
          child: Container(
            height: 135,
            padding:
            const EdgeInsets.only(top: 23, left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                const Text(
                  "Вы действительно хотите выйти?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(onTap: () {
                        onTap();
                      },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffE8E8E8),
                          ),
                          child: const Text(
                              "Да",
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14.5),
                          decoration: BoxDecoration(
                            // border: Border.all(color: color.main),
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xffF15959)
                          ),
                          child: const Text(
                            "Нет",
                            style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}