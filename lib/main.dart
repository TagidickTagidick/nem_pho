import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_page.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_provider.dart';
import 'package:nem_pho/presentation/loading_page/loading_page.dart';
import 'package:nem_pho/presentation/loading_page/loading_provider.dart';
import 'package:nem_pho/presentation/main_page/main_page.dart';
import 'package:nem_pho/presentation/main_page/main_parameters.dart';

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
      child: MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) =>
                  ChangeNotifierProvider<LoadingProvider>(
                      create:(_) => LoadingProvider(),
                      child: const LoadingPage()
                  ),
            ),
            GoRoute(
                path: '/main_page',
                builder: (context, state) => MainPage(mainParameters: state.extra as MainParameters)
            ),
            GoRoute(
                path: '/authorization_page',
                builder: (context, state) => ChangeNotifierProvider<AuthorizationProvider>(
                    create:(_) => AuthorizationProvider(),
                    child: const AuthorizationPage()
                ),
            ),
          ],
        ),
      ),
    );
  }
}
