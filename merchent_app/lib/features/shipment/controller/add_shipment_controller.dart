import 'dart:ffi';

import 'package:flutter/material.dart';
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
import '../../../utils/constants/colors.dart';
import '../../personalization/model/profile_model.dart';
import '../model/ShippingType.dart';
import '../model/shipment_model.dart';
import 'package:geolocator/geolocator.dart';


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
  RxString shipmentId = ''.obs; // Add shipmentId

  Rx<MerchantInfo> merchantInfo = MerchantInfo.empty().obs;
  var shippingTypes = <ShippingType>[].obs;
  RxInt selectedShippingTypeId = 0.obs; // Add this line

  RxDouble recipientLat = 0.0.obs;
  RxDouble recipientLong = 0.0.obs;
  RxString cityId = ''.obs;

  // Temporary fields for form values
  RxString tempRecipientName = ''.obs;
  RxString tempRecipientAddress = ''.obs;
  RxString tempRecipientPhone = ''.obs;
  RxString tempShipmentNote = ''.obs;
  RxDouble shipmentDistance = 0.0.obs;

  final Crud crud = Get.find<Crud>();

  void updateshipmentValue(value) {
    shipmentValue.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchShippingTypes();
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

  void fetchShippingTypes() async {
    var response = await crud.getData(
      'https://api.wasenahon.com/Kwickly/admin/shipping_types/get_shipping_types.php',
      {},
    );

    response.fold(
      (failure) {
        Get.snackbar('Error', 'Failed to connect to server');
      },
      (data) {
        if (data['status'] == true) {
          shippingTypes.value = (data['data'] as List)
              .map((item) => ShippingType.fromJson(item))
              .toList();
        } else {
          Get.snackbar('Error', 'Failed to fetch shipping types');
        }
      },
    );
  }

  void nextStep() {
    if (currentStep.value == 1) {
      if (recipientName.value.isEmpty ||
          recipientAddress.value.isEmpty ||
          recipientPhone.value.isEmpty) {
        Get.snackbar(
          'خطأ',
          'يرجى ملء جميع الحقول ',
          backgroundColor: TColors.error,
          colorText: TColors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: TColors.white),
        );
        return;
      }

      if (recipientPhone.value.length != 8) {
        Get.snackbar(
          'خطأ',
          'يجب أن يكون رقم الهاتف 8 أرقام',
          backgroundColor: TColors.error,
          colorText: TColors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: TColors.white),
        );
        return;
      }
    }

    if (currentStep.value == 2 &&
        (shipmentType.value.isEmpty ||
            shipmentWeight.value.isEmpty ||
            shipmentQuantity.value.isEmpty ||
            shipmentValue.value.isEmpty ||
            shipmentFee.value.isEmpty ||
            shipmentContents.value.isEmpty)) {
      Get.snackbar(
        'خطأ',
        'يرجى ملء جميع الحقول ',
        backgroundColor: TColors.error,
        colorText: TColors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: TColors.white),
      );
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
    shipmentNumber.value = ''; // Reset shipment number
    shipmentId.value = ''; // Reset shipment ID
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

    final selectedShippingType =
    shippingTypes.firstWhere((type) => type.type == shipmentType.value);
    final shippingTypeId = selectedShippingType.id;

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
      shipmentDistance: shipmentDistance.value.toString(), // إضافة المسافة
    );

    print(shipment.userId);
    print(shipment.recipientName);
    print(shipment.recipientPhone);
    print(shipment.recipientAddress);
    print(shipment.recipientLat);
    print(shipment.recipientLong);
    print(shipment.shipmentType);
    print(shipment.shipmentWeight);
    print(shipment.shipmentQuantity);
    print(shipment.shipmentValue);
    print(shipment.shipmentFee);
    print(shipment.shipmentContents);
    print(shipment.shipmentNote);
    print(shipment.recipientCity);
    print(shipment.shipmentDistance); // طباعة المسافة

    final response = await http.post(
      Uri.parse('${MerchantAPIKey}shipments/add.php'),
      body: shipment.toJson(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) {
        shipmentNumber.value = data['shipment_number'];
        shipmentId.value = data['shipment_id']; // Update shipmentId
        Get.snackbar(
          'نجاح',
          data['message'],
          backgroundColor: TColors.primary,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.check_circle_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
        Get.to(EBillScreen());
      } else {
        Get.snackbar(
          'خطأ',
          data['message'],
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.error_outline, color: Colors.white),
        );
      }
    } else {
      Get.snackbar(
        'خطأ',
        'فشل الاتصال بالسيرفر',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        icon: Icon(Icons.error_outline, color: Colors.white),
      );
    }
  }




  Future<double> calculateDistance(double startLat, double startLng, double endLat, double endLng) async {
    double distanceInMeters = Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm;
  }


  Future<void> calculateShippingFee() async {
    final distance = await calculateDistance(
      merchantInfo.value.addressLat,
      merchantInfo.value.addressLong,
      recipientLat.value,
      recipientLong.value,
    );

    shipmentDistance.value=distance;
    final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://api.wasenahon.com/Kwickly/merchant/shipments/calculateShippingFee.php'));

    final selectedShippingType =
        shippingTypes.firstWhere((type) => type.type == shipmentType.value);
    final shippingTypeId = selectedShippingType.id;

    request.fields.addAll({
      'shipment_type_id': shippingTypeId.toString(),
      'shipment_weight': shipmentWeight.value,
      'shipment_quantity': shipmentQuantity.value,
      'shipment_distance': distance.toString(),
      // استخدام المسافة الفعلية المحسوبة
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);

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
