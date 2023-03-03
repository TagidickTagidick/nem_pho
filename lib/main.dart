import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/loading_page.dart';
import 'package:nem_pho/ui/pages/main_page.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
      child: MaterialApp(
          routes: {
            "/loading": (context) => const LoadingPage(),
            "/main": (context) => const MainPage()
          },
          home: const LoadingPage()
      )
    );
  }
}
