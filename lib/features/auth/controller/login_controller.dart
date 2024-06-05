import 'package:get/get.dart';

import '../screen/login_screen.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var isValid = false.obs;
  var errorMessage = ''.obs;

  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
    validatePhoneNumber();
  }

  void validatePhoneNumber() {
    if (phoneNumber.value.length == 10) {
      isValid.value = true;
      errorMessage.value = '';
    } else {
      isValid.value = false;
      errorMessage.value = 'رقم الهاتف يجب أن يتكون من 10 أرقام';
    }
  }

  void login() {
    if (isValid.value) {
      // Proceed with login
      Get.offAll(() => LoginScreen());
    } else {
      errorMessage.value = 'يرجى إدخال رقم هاتف صالح';
    }
  }
}
