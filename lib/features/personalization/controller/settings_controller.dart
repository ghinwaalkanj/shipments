import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }
}
