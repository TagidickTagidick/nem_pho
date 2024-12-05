import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/core/services/network_client.dart';
import 'package:nem_pho/core/services/receiving_service.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_page.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_provider/authorization_provider.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_service/authorization_service.dart';
import 'package:nem_pho/presentation/cart_page/cart_page.dart';
import 'package:nem_pho/presentation/cart_page/cart_provider/cart_provider.dart';
import 'package:nem_pho/presentation/cart_page/cart_service/cart_service.dart';
import 'package:nem_pho/presentation/category_page/category_page.dart';
import 'package:nem_pho/presentation/category_page/category_provider/category_provider.dart';
import 'package:nem_pho/presentation/category_page/category_service/category_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_page.dart';
import 'package:nem_pho/presentation/loading_page/loading_provider/loading_provider.dart';
import 'package:nem_pho/presentation/loading_page/loading_service/loading_service.dart';
import 'package:nem_pho/presentation/main_page/main_page.dart';
import 'package:nem_pho/presentation/product_page/product_page.dart';
import 'package:nem_pho/presentation/product_page/product_provider/product_provider.dart';
import 'package:nem_pho/presentation/product_page/product_service/product_service.dart';
import 'package:nem_pho/presentation/profile_page/profile_page.dart';
import 'package:nem_pho/presentation/profile_page/profile_provider/profile_provider.dart';
import 'package:nem_pho/presentation/profile_page/profile_service/profile_service.dart';
import 'package:nem_pho/test_class.dart';
import 'package:provider/provider.dart';
import 'package:nem_pho/core/providers/common_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(MyApp());
}

class App extends StatelessWidget {
  App({super.key});

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            ChangeNotifierProvider<LoadingProvider>(
                create:(_) => LoadingProvider(
                    loadingService: LoadingService(
                        networkClient: NetworkClient(),
                        storageService: ReceivingService.getStorage()
                    ),
                    commonService: CommonService(
                        networkClient: NetworkClient(),
                        storageService: ReceivingService.getStorage()
                    )
                ),
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
            create:(_) => AuthorizationProvider(
              authorizationService: AuthorizationService(
                  networkClient: NetworkClient(),
                  storageService: ReceivingService.getStorage()
              ),
            ),
            child: const AuthorizationPage()
        ),
      ),
      GoRoute(
        path: '/profile_page',
        builder: (context, state) => ChangeNotifierProvider<ProfileProvider>(
            create:(_) => ProfileProvider(
                profileService: ProfileService(
                    networkClient: NetworkClient(),
                    storageService: ReceivingService.getStorage()
                ),
                commonService: CommonService(
                    networkClient: NetworkClient(),
                    storageService: ReceivingService.getStorage()
                )
            )..initUser(),
            child: const ProfilePage()
        ),
      ),
      GoRoute(
        path: '/cart_page',
        builder: (context, state) => ChangeNotifierProvider<CartProvider>(
            create:(_) => CartProvider(
                cartService: CartService(),
                commonService: CommonService(
                    networkClient: NetworkClient(),
                    storageService: ReceivingService.getStorage()
                )
            )..getProducts(),
            child: const CartPage()
        ),
      ),
      GoRoute(
        name: '/category_page',
        path: '/category_page/:id',
        builder: (context, state) => ChangeNotifierProvider<CategoryProvider>(
            create:(_) => CategoryProvider(
                categoryService: CategoryService(
                    networkClient: NetworkClient()
                )
            ),
            child: CategoryPage(id: state.pathParameters['id']!)
        ),
      ),
      GoRoute(
        name: '/product_page',
        path: '/product_page/:id',
        builder: (context, state) => ChangeNotifierProvider<ProductProvider>(
            create:(_) => ProductProvider(
                productService: ProductService(
                  networkClient: NetworkClient(),
                ),
                commonService: CommonService(
                  networkClient: NetworkClient(),
                  storageService: ReceivingService.getStorage(),
                )
            ),
            child: ProductPage(id: state.pathParameters['id']!)
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommonProvider(
            commonService: CommonService(
                networkClient: NetworkClient(),
                storageService: ReceivingService.getStorage()
            ))
        ),
      ],
      child: MaterialApp.router(
        supportedLocales: const [Locale('ru')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling,
            ),
            child: child!,
          );
        },
        routerConfig: router,
      ),
    );
  }
}