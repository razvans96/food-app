import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/controllers/product_search_controller.dart';
import 'package:food_app/pages/product_search_page.dart';
import 'package:food_app/services/product_search_service.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Debería mostrar un buscador y una lista de resultados',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ProductSearchController(
          productSearchService:
              ProductSearchService(), // Proporciona el servicio
        ),
        child: const MaterialApp(
          home: ProductSearchPage(),
        ),
      ),
    );

    // Verifica que el buscador esté presente
    expect(find.byType(TextField), findsOneWidget);

    // Verifica que el texto inicial sea "No se encontraron resultados."
    expect(find.text('No se encontraron resultados.'), findsOneWidget);
  });
}
