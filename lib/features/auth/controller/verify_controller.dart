import 'dart:async';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/core/integration/crud.dart';
import '../../../core/services/storage_service.dart';
import '../../../utils/constants/api_constants.dart';
import '../model/login_model.dart';
import '../model/verify_model.dart';
import '../screen/personal_info_screen.dart';

class VerifyController extends GetxController {
  var code = ''.obs;
  var errorMessage = ''.obs;
  var phoneNumber = ''.obs;
  var verificationCode ;
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
        '${MerchantAPIKey}auth/verify.php',
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
          VerifyResponseModel verifyResponse = VerifyResponseModel.fromJson(data);
          if (verifyResponse.status) {
            print(verifyResponse.status);
            print(verifyResponse.token);
            print(verifyResponse.userId);
            await SharedPreferencesHelper.setString('token', verifyResponse.token);
            await SharedPreferencesHelper.setInt('user_id', verifyResponse.userId);
            String? token = await SharedPreferencesHelper.getString('token');
            int? userId = await SharedPreferencesHelper.getInt('user_id');
            if (token != null && userId != null) {
              print('Token: $token, User ID: $userId');
            } else {
              print('No token or user_id found');
            }

            Get.to(() => PersonalInfoScreen());
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
    isLoading.value = true;
    var response = await crud.postData(
      '${MerchantAPIKey}auth/login.php', // Ensure this endpoint is correct
      {
        'phone': phoneNumber.value,
      },
      {},
    );
    isLoading.value = false;

    response.fold(
          (failure) {
        Get.snackbar('Error', 'فشل في إعادة إرسال رمز التحقق');
      },
          (data) {
            LoginResponseModel loginResponse = LoginResponseModel.fromJson(data);

              print(loginResponse.status);
              print(loginResponse.message);
              print(loginResponse.verificationCode);
              Get.snackbar(
                'Success',
                '${loginResponse.message}. رمز التحقق هو: ${loginResponse.verificationCode}',
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
