import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarcodeScannerButton extends StatelessWidget {
  final void Function(String? barcode) onScanned;
  final String label;
  final IconData icon;
  final int delayMillis;
  final CameraFace cameraFace;

  const BarcodeScannerButton({
    super.key,
    required this.onScanned,
    this.label = 'Escanear',
    this.icon = Icons.qr_code_scanner,
    this.delayMillis = 2000,
    this.cameraFace = CameraFace.back,
  });

  Future<void> _scanBarcode(BuildContext context) async {
    String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Escaner',
        centerTitle: false,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back),
      ),
      isShowFlashIcon: true,
      delayMillis: delayMillis,
      cameraFace: cameraFace,
      cancelButtonText: 'Cancelar',
    );
    if (context.mounted) {
      onScanned(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _scanBarcode(context),
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
