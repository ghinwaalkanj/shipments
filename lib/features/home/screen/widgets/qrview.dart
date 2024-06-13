import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../utils/constants/colors.dart';
import '../../controller/search_controller.dart';

class QrView extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final SEarchController searchController = Get.put(SEarchController());

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: searchController.onQRViewCreated,
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
