import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarcodeScannerStreamButton extends StatelessWidget {

  const BarcodeScannerStreamButton({
    super.key,
    required this.onBarcode,
    this.label = 'Escanear en streaming',
    this.icon = Icons.qr_code_scanner,
    this.delayMillis = 2000,
    this.cameraFace = CameraFace.back,
  });


  final void Function(String barcode) onBarcode;
  final String label;
  final IconData icon;
  final int delayMillis;
  final CameraFace cameraFace;

  void _startStream(BuildContext context) {
    SimpleBarcodeScanner.streamBarcode(
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
    ).listen((barcode) {
      if (barcode.isNotEmpty) {
        onBarcode(barcode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _startStream(context),
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
