import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import 'package:shipment_merchent_app/features/auth/screen/verification_screen.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
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
      errorMessage.value = 'رقم الهاتف يجب أن يتكون من 9 أرقام';
    } else {
      isValid.value = true;
      errorMessage.value = '';
    }
  }

  void login() async {
    if (isValid.value) {
      isLoading.value = true;
      var response = await crud.postData(
        LoginEndpoint,
        {'phone': '+9627${phoneNumber.value}', 'role': 'تاجر'},
        {},
      );
      isLoading.value = false;
      response.fold(
        (failure) {
          errorMessage.value = 'فشل في الاتصال بالخادم، أعد المحاولة';
          Get.snackbar(
            'خطأ',
            'فشل في الاتصال بالخادم، أعد المحاولة',
            backgroundColor: TColors.error,
            colorText: TColors.white,
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.all(10),
            borderRadius: 10,
            icon: Icon(Icons.error_outline, color: TColors.white),
          );
        },
        (data) {
          LoginResponseModel loginResponse = LoginResponseModel.fromJson(data);
          if (loginResponse.status) {
            Get.snackbar(
              'نجاح',
              'رمز التحقق هو: ${loginResponse.verificationCode}',
              backgroundColor: TColors.primary,
              colorText: TColors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(10),
              borderRadius: 10,
              icon: Icon(Icons.check_circle_outline, color: TColors.white),
              duration: Duration(seconds: 5),
            );
            Get.to(() => VerifyScreen(), arguments: {
              'verificationCode': loginResponse.verificationCode,
              'phoneNumber': '+9627${phoneNumber.value}',
            });
          } else {
            errorMessage.value = loginResponse.message;
            Get.snackbar(
              'خطأ',
              loginResponse.message,
              backgroundColor: TColors.error,
              colorText: TColors.white,
              snackPosition: SnackPosition.TOP,
              margin: EdgeInsets.all(10),
              borderRadius: 10,
              icon: Icon(Icons.error_outline, color: TColors.white),
            );
          }
        },
      );
    } else {
      errorMessage.value = 'يرجى إدخال رقم هاتف صالح';
    }
  }
}
