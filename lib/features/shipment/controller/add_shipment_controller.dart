import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shipment_merchent_app/features/shipment/screen/e_bill_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment2_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment3_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../personalization/model/profile_model.dart';
import '../model/shipment_model.dart';

class AddShipmentController extends GetxController {
  var currentStep = 1.obs;

  RxString recipientName = ''.obs;
  RxString recipientAddress = ''.obs;
  RxString recipientCity = ''.obs;
  RxString recipientPhone = ''.obs;
  RxString shipmentNote = ''.obs;

  RxString shipmentType = ''.obs;
  RxString shipmentWeight = ''.obs;
  RxString shipmentQuantity = ''.obs;
  RxString shipmentValue = ''.obs;
  RxString shipmentFee = ''.obs;
  RxString shipmentContents = ''.obs;
  RxString shipmentNumber = ''.obs;
  RxString shipmentId = ''.obs;

  Rx<MerchantInfo> merchantInfo = MerchantInfo.empty().obs;

  RxDouble recipientLat = 0.0.obs;
  RxDouble recipientLong = 0.0.obs;
  RxString cityId = ''.obs;

  // Temporary fields for form values
  RxString tempRecipientName = ''.obs;
  RxString tempRecipientAddress = ''.obs;
  RxString tempRecipientPhone = ''.obs;
  RxString tempShipmentNote = ''.obs;

  final Crud crud = Get.find<Crud>();

  void updateshipmentValue(value) {
    shipmentValue.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    shipmentType.listen((_) => calculateShippingFee());
    shipmentWeight.listen((_) => calculateShippingFee());
    shipmentQuantity.listen((_) => calculateShippingFee());
  }

  void fetchProfile() async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    var response = await crud.postData(
      '${MerchantAPIKey}profile.php',
      {'user_id': userId.toString()},
      {},
    );

    response.fold(
          (failure) {
        Get.snackbar('Error', 'Failed to fetch profile');
      },
          (data) {
        ProfileResponseModel responseModel =
        ProfileResponseModel.fromJson(data);
        merchantInfo.value = responseModel.merchantInfo;
      },
    );
  }

  void nextStep() {
    if (currentStep.value == 1 &&
        (recipientName.value.isEmpty ||
            recipientAddress.value.isEmpty ||
            recipientPhone.value.isEmpty)) {
      Get.snackbar('خطأ', 'يرجى ملء جميع الحقول ');
      return;
    }

    if (currentStep.value == 2 &&
        (shipmentType.value.isEmpty ||
            shipmentWeight.value.isEmpty ||
            shipmentQuantity.value.isEmpty ||
            shipmentValue.value.isEmpty ||
            shipmentFee.value.isEmpty ||
            shipmentContents.value.isEmpty)) {
      Get.snackbar('خطأ', 'يرجى ملء جميع الحقول');
      return;
    }

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
      Get.to(() => ShipmentStep1Screen(), arguments: {
        'recipientName': recipientName.value,
        'recipientAddress': recipientAddress.value,
        'recipientPhone': recipientPhone.value,
        'shipmentNote': shipmentNote.value,
        'shipmentType': shipmentType.value,
        'shipmentWeight': shipmentWeight.value,
        'shipmentQuantity': shipmentQuantity.value,
        'shipmentValue': shipmentValue.value,
        'shipmentFee': shipmentFee.value,
        'shipmentContents': shipmentContents.value,
      });
    } else if (currentStep.value == 2) {
      Get.to(() => ShipmentStep2Screen(), arguments: {
        'recipientName': recipientName.value,
        'recipientAddress': recipientAddress.value,
        'recipientPhone': recipientPhone.value,
        'shipmentNote': shipmentNote.value,
        'shipmentType': shipmentType.value,
        'shipmentWeight': shipmentWeight.value,
        'shipmentQuantity': shipmentQuantity.value,
        'shipmentValue': shipmentValue.value,
        'shipmentFee': shipmentFee.value,
        'shipmentContents': shipmentContents.value,
      });
    } else if (currentStep.value == 3) {
      Get.to(() => ShipmentStep3Screen(), arguments: {
        'recipientName': recipientName.value,
        'recipientAddress': recipientAddress.value,
        'recipientPhone': recipientPhone.value,
        'shipmentNote': shipmentNote.value,
        'shipmentType': shipmentType.value,
        'shipmentWeight': shipmentWeight.value,
        'shipmentQuantity': shipmentQuantity.value,
        'shipmentValue': shipmentValue.value,
        'shipmentFee': shipmentFee.value,
        'shipmentContents': shipmentContents.value,
      });
    }
  }

  void resetFields() {
    recipientName.value = '';
    recipientAddress.value = '';
    recipientCity.value = '';
    recipientPhone.value = '';
    shipmentNote.value = '';
    shipmentType.value = '';
    shipmentWeight.value = '';
    shipmentQuantity.value = '';
    shipmentValue.value = '';
    shipmentFee.value = '';
    shipmentContents.value = '';
    shipmentNumber.value = '';  // Reset shipment number
    recipientLat.value = 0.0;
    recipientLong.value = 0.0;
    cityId.value = '';
    tempRecipientName.value = '';
    tempRecipientAddress.value = '';
    tempRecipientPhone.value = '';
    tempShipmentNote.value = '';
    currentStep.value = 1;
  }

  void confirmShipment() async {
    var userId = await SharedPreferencesHelper.getInt('user_id');
    final shipment = ShipmentModel(
      userId: userId.toString(),
      recipientName: recipientName.value,
      recipientPhone: recipientPhone.value,
      recipientAddress: recipientAddress.value,
      recipientLat: recipientLat.value.toString(),
      recipientLong: recipientLong.value.toString(),
      shipmentType: shipmentType.value,
      shipmentWeight: shipmentWeight.value,
      shipmentQuantity: shipmentQuantity.value,
      shipmentValue: shipmentValue.value,
      shipmentFee: shipmentFee.value,
      shipmentContents: shipmentContents.value,
      shipmentNote: shipmentNote.value.isEmpty ? 'لا يوجد' : shipmentNote.value,
      recipientCity: recipientCity.value,
    );

    final response = await http.post(
      Uri.parse('${MerchantAPIKey}shipments/add.php'),
      body: shipment.toJson(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        shipmentNumber.value = data['shipment_number'];
        Get.snackbar('نجاح', data['message']);
        print(response.statusCode);
        print(data['status']);
        print(data['message']);
        Get.to(EBillScreen());
      } else {
        Get.snackbar('خطأ', data['message']);
      }
    } else {
      Get.snackbar('خطأ', 'فشل الاتصال بالسيرفر');
    }
  }

  Future<void> calculateShippingFee() async {
    final response = await http.post(
      Uri.parse(
          'https://api.wasenahon.com/Kwickly/merchant/shipments/calculateShippingFee.php'),
      body: {
        'shipment_type': shipmentType.value,
        'shipment_weight': shipmentWeight.value,
        'shipment_quantity': shipmentQuantity.value,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        shipmentFee.value = data['shipment_fee'].toString();
        print('تكاليف الشحن: ${shipmentFee.value}');
      } else {
        print('خطأ');
        print(data['message']);
      }
    } else {
      Get.snackbar('خطأ', 'فشل الاتصال بالسيرفر لحساب تكاليف الشحن');
    }
  }
}
