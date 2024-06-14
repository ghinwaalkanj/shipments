import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  var currentPageIndex = 0.obs;
  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    checkIfFirstTime();
  }

  Future<void> checkIfFirstTime() async {
    prefs = await SharedPreferences.getInstance();
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
