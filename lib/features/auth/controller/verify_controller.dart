import 'package:get/get.dart';

class VerifyController extends GetxController {
  var code = ''.obs;
  var errorMessage = ''.obs;
  var phoneNumber = '+963 969 741 985'.obs;
  var resendCountdown = 47.obs;

  void updateCode(String value) {
    code.value = value;
  }

  void verifyCode() {
    if (code.value.length == 4) {
      // Perform verification logic
    } else {
      errorMessage.value = 'Please enter the 4-digit code';
    }
  }

  void resendCode() {
    // Logic to resend the code
    resendCountdown.value = 47;
  }

  @override
  void onInit() {
    super.onInit();
    // Start countdown timer logic
  }
}
