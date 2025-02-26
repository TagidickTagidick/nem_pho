import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';
import 'package:nem_pho/presentation/authorization_page/widgets/enter_button.dart';
import 'package:nem_pho/presentation/authorization_page/widgets/enter_field.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/core/widgets/custom/mask_text_input_formatter.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_provider/authorization_provider.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _phoneController = TextEditingController();

  bool _canSignIn = false;

  ///проверяет кол-во символов
  ///Если пользователь ввел полностью номер телефон, то показывается кнопка
  void _checkCanSignIn(String value) {
    if (_phoneController.text.length == 18) {
      _canSignIn = true;
      setState(() {});
      return;
    }
    _canSignIn = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppMetricaService().sendLoadingPageEvent('AuthorizationPage');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 33, top: 76),
            child: Text(
              'Авторизация',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: Color(0xff000000)
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 33, top: 24),
            child: Text(
              'Введите номер мобильного телефона',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff000000)
              ),
            ),
          ),
          const SizedBox(height: 7),
          EnterField(
              phoneController: _phoneController,
              checkCanSignIn: _checkCanSignIn
          ),
          const SizedBox(height: 74),
          if (_canSignIn)
            EnterButton(phoneController: _phoneController)
        ],
      ),
    );
  }
}