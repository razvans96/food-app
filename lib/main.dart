import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/pages/product_query_page.dart';
import 'package:food_app/pages/product_search_page.dart';
import 'package:food_app/pages/user_login_page.dart';
import 'package:food_app/pages/user_register_page.dart';
import 'package:food_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: './dotenv');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userController = UserController();
  await userController.checkUserValidity();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/query',
      routes: {
        '/login': (context) => const UserLoginPage(),
        '/register': (context) => const UserRegisterPage(),
        '/query': (context) => const ProductQueryPage(),
        '/search': (context) =>
            const ProductSearchPage(),
      },
    );
  }
}
