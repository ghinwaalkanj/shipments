import 'package:get/get.dart';

class BarcodeScanController extends GetxController {
  var barcode = ''.obs;

  void updateBarcode(String newBarcode) {
    barcode.value = newBarcode;
  }
}
