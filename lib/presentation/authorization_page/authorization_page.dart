import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';
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

  bool canSignIn = false;

  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void checkCanSignIn() {
    if (_phoneController.text.length == 18) {
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
          Container(
            height: 63,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            color: const Color(0xffF3F3F3),
            padding: const EdgeInsets.only(left: 36),
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
                    color: Colors.white.withOpacity(0.3)
                ),
              ),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xff6D6D6D)
              ),
              inputFormatters: [maskFormatter],
            ),
          ),
          const SizedBox(height: 74),
          if (canSignIn)
            Expanded(
              child: Column(
                children: <Widget>[
                  GestureDetector(onTap: () async {
                    final bool success = await context.read<
                        AuthorizationProvider>().register(
                        _phoneController.text.replaceAll(" ", "_"));
                    context.read<CommonProvider>().changeUser();
                    await context.read<CommonProvider>().getIsWorking();
                    if (success) {
                      context.push('/profile_page');
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