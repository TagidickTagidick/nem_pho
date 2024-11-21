import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/providers/common_provider.dart';

class NotWorking extends StatelessWidget {
  const NotWorking({super.key});

  @override
  Widget build(BuildContext context) {
    return context.watch<CommonProvider>().isWorking ? const SizedBox() : const SizedBox(
      height: 60,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Внимание! На данный момент доставка не работает!',
            textAlign: TextAlign.center,
          ),
          Text(
            'Вернитесь в приложение с 11:30 до 20:30',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
