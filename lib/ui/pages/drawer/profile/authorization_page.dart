import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/drawer/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../cart_provider.dart';
import '../../../widgets/custom/mask_text_input_formatter.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool canSignIn = false;

  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void checkCanSignIn() {
    if (_phoneController.text.length == 18 || _nameController.text.isNotEmpty) {
      setState(() {
        canSignIn = true;
      });
    } else {
      setState(() {
        canSignIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 33,
              top: 76,
            ),
            child: Text(
              'Авторизация',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: Color(0xff0000000)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 33,
              top: 24,
            ),
            child: Text(
              'введите номер мобильного телефона',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff0000000)),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            height: 63,
            width: double.infinity,
            color: const Color(0xffF3F3F3),
            padding: const EdgeInsets.only(
              left: 36,
            ),
            child: TextField(
              controller: _phoneController,
              maxLength: 18,
              autofocus: true,
              cursorHeight: 26,
              cursorColor: const Color(0xffff9900),
              onChanged: (value) {
                checkCanSignIn();
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.white.withOpacity(0.3)),
              ),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xff6D6D6D)),
              inputFormatters: [maskFormatter],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 33,
              top: 24,
            ),
            child: Text(
              'введите имя',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff0000000)),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            height: 63,
            width: double.infinity,
            color: const Color(0xffF3F3F3),
            padding: const EdgeInsets.only(
              left: 36,
            ),
            child: TextField(
              controller: _nameController,
              maxLength: 18,
              autofocus: true,
              cursorHeight: 26,
              cursorColor: const Color(0xffff9900),
              onChanged: (value) {
                checkCanSignIn();
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.white.withOpacity(0.3)),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Color(0xff6D6D6D),
              ),
            ),
          ),
          const SizedBox(height: 74),
          if (canSignIn)
            Expanded(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      String phone = _phoneController.text.replaceAll(" ", "_");
                      FirebaseDatabase.instance
                          .ref()
                          .child("users/$phone")
                          .update({
                        "phone": phone,
                        "name": _nameController.text,
                      });
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString(
                        "phone",
                        phone,
                      );
                      if (mounted) {
                        await context
                            .read<CartProvider>()
                            .getUserData()
                            .then((value) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ));
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      color: const Color(0xffF3F3F3),
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      child: const Text(
                        'Войти',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Text(
                          'Нажимая “получить код”, вы принимаете условия',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {},
                          borderRadius: BorderRadius.circular(5),
                          child: const Text(
                            'Пользовательского соглашения',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
