import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/features/auth/screen/verification_screen.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var isValid = false.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  final Crud crud = Get.find<Crud>();
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
    phoneNumber.value = ''; // Default value
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void updatePhoneNumber(String value) {
    // Remove non-digit characters
    String digits = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length > 8) {
      digits = digits.substring(0, 8);
      FocusScope.of(Get.context!).unfocus(); // Hide the keyboard
    }

    phoneNumber.value = digits;
    validatePhoneNumber();
  }

  void validatePhoneNumber() {
    if (phoneNumber.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = 'يرجى إدخال رقم الهاتف';
    } else if (phoneNumber.value.length != 8) {
      isValid.value = false;
      errorMessage.value = 'رقم الهاتف يجب أن يتكون من 8 أرقام';
    } else {
      isValid.value = true;
      errorMessage.value = '';
    }
  }

  void login() async {
    if (isValid.value) {
      isLoading.value = true;
      var response = await crud.postData(
        '${MerchantAPIKey}auth/login.php',
        {'phone': '+9627${phoneNumber.value}', 'role': 'تاجر'},
        {},
      );
      isLoading.value = false;
      response.fold(
            (failure) {
          errorMessage.value = 'فشل في الاتصال بالخادم، أعد المحاولة';
        },
            (data) {
          LoginResponseModel loginResponse = LoginResponseModel.fromJson(data);
          if (loginResponse.status) {
            Get.snackbar(
              'Success',
              '${loginResponse.message}. رمز التحقق هو: ${loginResponse.verificationCode}',
            );
            Get.to(() => VerifyScreen(), arguments: {
              'verificationCode': loginResponse.verificationCode,
              'phoneNumber': '+9627${phoneNumber.value}',
            });
          } else {
            errorMessage.value = loginResponse.message;
            Get.snackbar('Error', loginResponse.message);
          }
        },
      );
    } else {
      errorMessage.value = 'يرجى إدخال رقم هاتف صالح';
    }
  }
}
