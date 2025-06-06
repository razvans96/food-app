import 'package:flutter/material.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/models/product_food.dart';
import 'package:food_app/services/product_query_service.dart';
import 'package:food_app/widgets/product_details.dart';
import 'package:food_app/widgets/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ProductQueryPage extends StatefulWidget {
  const ProductQueryPage({super.key});

  @override
  State<ProductQueryPage> createState() => _ProductQueryPageState();
}

class _ProductQueryPageState extends State<ProductQueryPage> {
  String? result;
  BarcodeViewController? controller;
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
    final userController = context.watch<UserController>();
    final isLoggedIn = userController.currentUser != null;
    print('Usuario actual: ${userController.currentUser}');
    return Scaffold(
      appBar: AppBar(
        leading: isLoggedIn
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Opciones del menú
                  Scaffold.of(context).openDrawer();
                },
              )
            : null,
        title: const Text('Consulta de productos'),
        actions: [
          if (isLoggedIn)
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Opciones del usuario
              },
            )
          else
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Acceso'),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                child: SimpleBarcodeScanner(
                  scaleHeight: 400,
                  scaleWidth: 600,
                  onScanned: (code) {
                    if (code.isNotEmpty && code != result) {
                      setState(() {
                        result = code;
                      });
                      _fetchProduct(code);
                    }
                  },
                  continuous: true,
                  onBarcodeViewCreated: (BarcodeViewController c) {
                    controller = c;
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMsg != null
                    ? Center(
                        child: Text(errorMsg!,
                            style: const TextStyle(color: Colors.red)))
                    : product != null
                        ? ProductDetails(product: product!)
                        : const WelcomeView(),
          ),
        ],
      ),
    );
  }
}
