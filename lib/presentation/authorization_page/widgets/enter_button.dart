import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_provider/authorization_provider.dart';
import 'package:provider/provider.dart';

class EnterButton extends StatelessWidget {
  const EnterButton({super.key, required this.phoneController});

  final TextEditingController phoneController;

  void _register(BuildContext context) async {
    final bool success = await context.read<
        AuthorizationProvider>().register(
        phoneController.text.replaceAll(" ", "_"));
    context.read<CommonProvider>().changeUser();
    await context.read<CommonProvider>().getIsWorking();
    if (success) {
      context.push('/profile_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          GestureDetector(onTap: () => _register(context),
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
    );
  }
}
