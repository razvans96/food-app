import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/home_page.dart';
import 'package:provider/provider.dart';
import 'package:food_app/controllers/search_product_controller.dart';
import 'package:food_app/services/food_api_service.dart';

void main() {
  testWidgets('Debería mostrar un buscador y una lista de resultados', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => SearchProductController( 
          foodApiService: FoodApiService(), // Proporciona el servicio
        ),
        child: const MaterialApp(
          home: MyHomePage(title: 'Buscador de alimentos'),
        ),
      ),
    );

    // Verifica que el buscador esté presente
    expect(find.byType(TextField), findsOneWidget);

    // Verifica que el texto inicial sea "No se encontraron resultados."
    expect(find.text('No se encontraron resultados.'), findsOneWidget);
  });
}