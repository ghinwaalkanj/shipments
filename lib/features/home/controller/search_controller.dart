import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/search_model.dart';
import '../screen/search_screen.dart';

class SEarchController extends GetxController {
  var isLoading = false.obs;
  var searchResult = Rxn<SearchResult>();
  var barcode = ''.obs;
  var isFlashOn = false.obs;
  QRViewController? qrController;

  Future<void> searchShipment(String shipmentNumber) async {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse(SearchShipmenEndpoint),
      body: {'shipment_number': shipmentNumber},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        searchResult.value = SearchResult.fromJson(data);
      } else {
        searchResult.value = null;
      }
    } else {
      searchResult.value = null;
    }

    isLoading.value = false;
  }

  void updateBarcode(String code) {
    barcode.value = code;
  }

  Future<void> searchShipmentByBarcode() async {
    String shipmentNumber = barcode.value;
    if (shipmentNumber.isNotEmpty) {
      await searchShipment(shipmentNumber);
      if (searchResult.value != null) {
        Get.to(() => const SearchScreen());
      } else {
        Get.snackbar('Error', 'Shipment not found');
      }
    }
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      updateBarcode(scanData.code ?? "");
      await controller.pauseCamera();
      await searchShipmentByBarcode();
    });
  }

  void toggleFlashlight() {
    if (qrController != null) {
      qrController!.toggleFlash();
      isFlashOn.value = !isFlashOn.value;
    }
  }
}
