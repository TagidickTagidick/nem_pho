import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nem_pho/ui/pages/loading_page.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: const LoadingPage(),
        ),
      ),
    );
  }
}
