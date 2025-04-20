import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:food_app/services/product_query_service.dart';
import 'package:food_app/models/simple_product.dart';

class ProductQueryPage extends StatefulWidget {
  const ProductQueryPage({super.key});

  @override
  State<ProductQueryPage> createState() => _ProductQueryPageState();
}

class _ProductQueryPageState extends State<ProductQueryPage> {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final currentContext = context;
          
          String? res = await SimpleBarcodeScanner.scanBarcode(
            currentContext,
            barcodeAppBar: const BarcodeAppBar(
              appBarTitle: 'Test',
              centerTitle: false,
              enableBackButton: true,
              backButtonIcon: Icon(Icons.arrow_back_ios),
            ),
            isShowFlashIcon: true,
            delayMillis: 2000,
            cameraFace: CameraFace.back, // Cambiar a cámara trasera
          );

          if (res != null && res.isNotEmpty) {
            try {
              final product = await ProductQueryService().getProduct(res);
              showDialog(
                context: currentContext,
                builder: (dialogContext) => AlertDialog(
                  title: Text(product.name ?? 'Producto desconocido'),
                  content: Text(product.brands ?? 'Marca desconocida'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            } catch (e) {
              ScaffoldMessenger.of(currentContext).showSnackBar(
                SnackBar(content: Text('Error al obtener el producto: $e')),
              );
              debugPrint('Error: $e');
            }
          }
        },
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Escanear'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}