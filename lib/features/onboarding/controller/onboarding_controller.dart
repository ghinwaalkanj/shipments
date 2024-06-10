import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../navigation_menu.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  var currentPageIndex = 0.obs;
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    _checkIfFirstTime();
  }

  Future<void> _checkIfFirstTime() async {
    prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    bool isAuth = prefs.getBool('isAuth') ?? false;

    if (isAuth == true) {
      Get.offAll(() => const NavigationMenu());
    } else if (isFirstTime == false) {
      Get.offAll(() => const LoginScreen());
    }
  }

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value < 2) {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
      currentPageIndex.value = page;
    } else {
      prefs.setBool('isFirstTime', false);
      Get.offAll(() => const LoginScreen());
    }
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      int page = currentPageIndex.value - 1;
      pageController.jumpToPage(page);
      currentPageIndex.value = page;
    }
  }
}
