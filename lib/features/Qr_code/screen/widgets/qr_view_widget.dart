import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

class QrViewWidget extends StatelessWidget {
  final GlobalKey qrKey;
  final void Function(QRViewController) onQRViewCreated;

  const QrViewWidget({
    Key? key,
    required this.qrKey,
    required this.onQRViewCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: TColors.primary,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 200.0,
      ),
    );
  }
}
