import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_page.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_provider.dart';
import 'package:nem_pho/presentation/cart_page/cart_page.dart';
import 'package:nem_pho/presentation/category_page/category_page.dart';
import 'package:nem_pho/presentation/category_page/category_provider/category_provider.dart';
import 'package:nem_pho/presentation/category_page/category_service/category_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_page.dart';
import 'package:nem_pho/presentation/loading_page/loading_provider.dart';
import 'package:nem_pho/presentation/main_page/main_page.dart';
import 'package:nem_pho/presentation/product_page/product_page.dart';
import 'package:nem_pho/presentation/product_page/product_provider/product_provider.dart';
import 'package:nem_pho/presentation/product_page/product_service/product_service.dart';
import 'package:nem_pho/presentation/profile_page/profile_page.dart';
import 'package:nem_pho/presentation/profile_page/profile_provider/profile_provider.dart';

import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'core/providers/common_provider.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final GoRouter router = GoRouter(
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
          builder: (context, state) => const MainPage()
      ),
      GoRoute(
        path: '/authorization_page',
        builder: (context, state) => ChangeNotifierProvider<AuthorizationProvider>(
            create:(_) => AuthorizationProvider(),
            child: const AuthorizationPage()
        ),
      ),
      GoRoute(
        path: '/profile_page',
        builder: (context, state) => ChangeNotifierProvider<ProfileProvider>(
            create:(_) => ProfileProvider(),
            child: const ProfilePage()
        ),
      ),
      GoRoute(
        path: '/cart_page',
        builder: (context, state) => ChangeNotifierProvider<CartProvider>(
            create:(_) => CartProvider(),
            child: const CartPage()
        ),
      ),
      GoRoute(
        name: '/category_page',
        path: '/category_page/:id',
        builder: (context, state) => ChangeNotifierProvider<CategoryProvider>(
            create:(_) => CategoryProvider(categoryService: CategoryService()),
            child: CategoryPage(id: state.pathParameters['id']!)
        ),
      ),
      GoRoute(
        name: '/product_page',
        path: '/product_page/:id',
        builder: (context, state) => ChangeNotifierProvider<ProductProvider>(
            create:(_) => ProductProvider(productService: ProductService()),
            child: ProductPage(id: state.pathParameters['id']!)
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CommonProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}