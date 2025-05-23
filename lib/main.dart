import 'package:flutter/material.dart';
import 'package:food_app/pages/product_query_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



Future main() async {
  await dotenv.load(fileName: './dotenv');
  runApp(const MyApp());
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
        home: const ProductQueryPage(),
    );
  }
}


