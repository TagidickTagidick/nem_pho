import 'package:flutter/material.dart';
import 'package:nem_pho/presentation/loading_page/loading_page.dart';
import 'package:nem_pho/presentation/loading_page/loading_provider.dart';

import 'package:provider/provider.dart';
import 'cart_provider.dart';

void main() async {
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
        home: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: ChangeNotifierProvider<LoadingProvider>(
              create:(_) => LoadingProvider(),
              child: const LoadingPage()
          ),
        ),
      ),
    );
  }
}
