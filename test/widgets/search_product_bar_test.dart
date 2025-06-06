import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/widgets/search_product_bar.dart';

void main() {
  testWidgets('Debería mostrar un campo de texto y un botón de búsqueda',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    bool searchTriggered = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchProductBar(
            controller: controller,
            onSearch: () {
              searchTriggered = true;
            },
          ),
        ),
      ),
    );

    // Verifica que el campo de texto esté presente
    expect(find.byType(TextField), findsOneWidget);

    // Ingresa texto en el campo de texto
    await tester.enterText(find.byType(TextField), 'apple');
    expect(controller.text, 'apple');

    // Presiona el botón de búsqueda
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    // Verifica que se haya activado la búsqueda
    expect(searchTriggered, isTrue);
  });
}
