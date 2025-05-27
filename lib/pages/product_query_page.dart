import 'package:flutter/material.dart';
import 'package:food_app/services/product_query_service.dart';
import 'package:food_app/services/ui_service.dart';
import 'package:food_app/widgets/barcode_scanner_stream_button.dart';

class ProductQueryPage extends StatefulWidget {
  const ProductQueryPage({super.key});

  @override
  State<ProductQueryPage> createState() => _ProductQueryPageState();
}

class _ProductQueryPageState extends State<ProductQueryPage> {
  bool _bottomSheetOpen = false;

  Future<void> _onBarcodeStream(String barcode) async {
    if (!mounted) return;
    if (barcode.isNotEmpty) {
      if (_bottomSheetOpen) {
        Navigator.of(context).pop();
        await Future.delayed(const Duration(milliseconds: 200));
      }
      try {
        final product = await ProductQueryService().getProduct(barcode);
        if (!mounted) return;
        _bottomSheetOpen = true;
        await UIService.showProductBottomSheet(context, product);
      } catch (e) {
        if (!mounted) return;
        UIService.showErrorSnackBar(context, 'Error al obtener el producto: $e');
        debugPrint('Error: $e');
      } finally {
        _bottomSheetOpen = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Bienvenido a Alimentos',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Escanea tu producto',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: BarcodeScannerStreamButton(
        onBarcode: _onBarcodeStream,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}