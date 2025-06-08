import 'package:flutter/material.dart';
import 'package:food_app/models/product_food.dart';
import 'package:food_app/services/product_query_service.dart';
import 'package:food_app/widgets/barcode_scanner_button.dart';
import 'package:food_app/widgets/custom_app_bar.dart';
import 'package:food_app/widgets/product_details.dart';
import 'package:food_app/widgets/welcome_view.dart';

class ProductQueryPage extends StatefulWidget {
  const ProductQueryPage({super.key});

  @override
  State<ProductQueryPage> createState() => _ProductQueryPageState();
}

class _ProductQueryPageState extends State<ProductQueryPage> {
  String? result;
  ProductFood? product;
  bool isLoading = false;
  String? errorMsg;

  Future<void> _fetchProduct(String code) async {
    setState(() {
      isLoading = true;
      errorMsg = null;
    });
    try {
      final fetchedProduct = await ProductQueryService().getProduct(code);
      setState(() {
        product = fetchedProduct as ProductFood?;
        isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        errorMsg = 'Error al obtener el producto: $e';
        isLoading = false;
      });
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const CustomAppBar(title: 'Escáner'),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeScannerButton(
              onScanned: (code) async {
                if (code!.isNotEmpty) {
                  await _fetchProduct(code);
                }
              },
            ),
            const SizedBox(height: 24),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMsg != null)
              Text(
                errorMsg!,
                style: const TextStyle(color: Colors.red),
              )
            else if (product != null)
              ProductDetails(product: product!)
            else
              const WelcomeView(),
          ],
        ),
      ),
    ),
  );
}
}
