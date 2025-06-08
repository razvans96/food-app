import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarcodeScannerButton extends StatelessWidget {

  const BarcodeScannerButton({
    required this.onScanned,
    super.key,
    this.label = 'Escanear',
    this.icon = Icons.qr_code_scanner,
    this.delayMillis = 2000,
    this.cameraFace = CameraFace.back,
  });
  
  final void Function(String? barcode) onScanned;
  final String label;
  final IconData icon;
  final int delayMillis;
  final CameraFace cameraFace;

  Future<void> _scanBarcode(BuildContext context) async {
    final res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Escáner',
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
