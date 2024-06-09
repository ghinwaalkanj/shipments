import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment2_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment3_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/shipment_model.dart';

class ShipmentController extends GetxController {
  var currentStep = 1.obs;

  RxString recipientName = ''.obs;
  RxString recipientAddress = ''.obs;
  RxString recipientPhone = ''.obs;
  RxString shipmentNote = ''.obs;

  RxString shipmentType = ''.obs;
  RxString shipmentWeight = ''.obs;
  RxString shipmentQuantity = ''.obs;
  RxString shipmentValue = ''.obs;

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
      navigateToCurrentStep();
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
      navigateToCurrentStep();
    }
  }

  void navigateToCurrentStep() {
    if (currentStep.value == 1) {
      Get.to(() => ShipmentStep1Screen());
    } else if (currentStep.value == 2) {
      Get.to(() => ShipmentStep2Screen());
    } else if (currentStep.value == 3) {
      Get.to(() => ShipmentStep3Screen());
    }
  }

  void confirmShipment() async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    final shipment = ShipmentModel(
      userId:userId.toString(),
      recipientName: recipientName.value,
      recipientPhone: recipientPhone.value,
      recipientAddress: recipientAddress.value,
      recipientLat: "33.504195",
      recipientLong: "33.504195",
      shipmentType: shipmentType.value,
      shipmentWeight: shipmentWeight.value,
      shipmentQuantity: shipmentQuantity.value,
      shipmentValue: shipmentValue.value,
      shipmentNote: shipmentNote.value ?? 'لا يوجد',
      shipmentContents: 'غير محدد',
      shipmentFee: "100000",
    );

    final response = await http.post(
      Uri.parse('${MerchantAPIKey}shipments/add.php'),
      body: shipment.toJson(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        Get.snackbar('نجاح', data['message']);
        print(response.statusCode);
        print(data['status'] );
        print(data['message'] );
      } else {
        Get.snackbar('خطأ', data['message']);
      }
    } else {
      Get.snackbar('خطأ', 'فشل الاتصال بالسيرفر');
    }
  }
}
