import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/colors.dart';
import '../model/login_model.dart';
import '../model/verify_model.dart';
import '../screen/personal_info_screen.dart';

class VerifyController extends GetxController {
  var code = ''.obs;
  var errorMessage = ''.obs;
  var phoneNumber = ''.obs;
  var verificationCode;
  var resendCountdown = 59.obs;
  var isLoading = false.obs;

  final Crud crud = Get.find<Crud>();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      phoneNumber.value = Get.arguments['phoneNumber'] ?? '';
      verificationCode = Get.arguments['verificationCode'] ?? '';
    }
    startCountdown();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void updateCode(String value) {
    code.value = value;
  }

  void verifyCode() async {
    if (code.value.length == 5) {
      isLoading.value = true;
      var response = await crud.postData(
        VerifyEndpoint,
        {
          'phone': phoneNumber.value,
          'verification_code': code.value,
        },
        {},
      );
      isLoading.value = false;
      response.fold(
        (failure) {
          errorMessage.value = 'فشل في الاتصال بالخادم';
        },
        (data) async {
          VerifyResponseModel verifyResponse =
              VerifyResponseModel.fromJson(data);
          if (verifyResponse.status) {
            print(verifyResponse.status);
            print(verifyResponse.token);
            print(verifyResponse.userId);
            print(verifyResponse.name);
            print(verifyResponse.nationalId);
            print(verifyResponse.gender);
            await SharedPreferencesHelper.setString(
                'token', verifyResponse.token);
            await SharedPreferencesHelper.setInt(
                'user_id', verifyResponse.userId);
            String? token = await SharedPreferencesHelper.getString('token');
            int? userId = await SharedPreferencesHelper.getInt('user_id');
            if (token != null && userId != null) {
              print('verifyToken: $token, User ID: $userId');
            } else {
              print('No token or user_id found');
            }

            Get.to(() => PersonalInfoScreen(), arguments: {
              'name': verifyResponse.name ?? '',
              'national_id': verifyResponse.nationalId ?? '',
              'business_name': verifyResponse.businessName ?? '',
              'gender': verifyResponse.gender ?? '',
            });
          } else {
            errorMessage.value = 'رمز التحقق غير صحيح';
            Get.snackbar('Error', 'رمز التحقق غير صحيح');
          }
        },
      );
    } else {
      errorMessage.value = 'يرجى إدخال رمز التحقق المكون من 5 أرقام';
    }
  }

  void resendCode() async {
    var response = await crud.postData(
      '${MerchantAPIKey}auth/login.php', // Ensure this endpoint is correct
      {
        'phone': phoneNumber.value,
      },
      {},
    );

    response.fold(
      (failure) {
        Get.snackbar('Error', 'فشل في إعادة إرسال رمز التحقق');
      },
      (data) {
        LoginResponseModel loginResponse = LoginResponseModel.fromJson(data);

        verificationCode =
            loginResponse.verificationCode; // Update the verificationCode
        Get.snackbar(
          'نجاح',
          'رمز التحقق الجديد هو: ${loginResponse.verificationCode}',
          backgroundColor: TColors.primary,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          icon: Icon(Icons.check_circle_outline, color: Colors.white),
          duration: Duration(seconds: 5),
        );
        startCountdown();
      },
    );
  }

  void startCountdown() {
    resendCountdown.value = 59;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        timer.cancel();
      }
    });
  }
}
