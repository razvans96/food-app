import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/pages/login_page.dart';
import 'package:food_app/pages/register_page.dart';
import 'package:food_app/pages/product_search_page.dart';
import 'package:food_app/controllers/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:food_app/pages/product_query_page.dart';



Future main() async {
  await dotenv.load(fileName: './dotenv');
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginController(),
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/query': (context) => ProductQueryPage(),
          '/search': (context) => ProductSearchPage(title: 'Buscador de productos'),
          
        },    
    );
  }
}


