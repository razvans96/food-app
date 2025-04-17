import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/search_product_controller.dart';
import 'services/food_api_service.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchProductController(
            foodApiService: FoodApiService(), // Proporciona el servicio
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Buscador de alimentos'),
      ),
    );
  }
}


