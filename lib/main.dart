import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';
import 'package:shipment_merchent_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:shipment_merchent_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:sizer/sizer.dart';
import 'core/integration/crud.dart';
import 'core/services/InternetController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Crud());
  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());
  final InternetController internetController = Get.put(InternetController());
  await onBoardingController.checkIfFirstTime();

  // Set the default status bar color
  FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

  runApp(MyApp(
      onBoardingController: onBoardingController,
      internetController: internetController));
}

class MyApp extends StatelessWidget {
  final OnBoardingController onBoardingController;
  final InternetController internetController;

  MyApp({required this.onBoardingController, required this.internetController});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        internetController.checkConnection(); // Initial check
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: onBoardingController.prefs.getBool('isAuth') == true
                ? NavigationMenu()
                : onBoardingController.prefs.getBool('isFirstTime') == false
                    ? LoginScreen()
                    : OnBoardingScreen(),

        );
      },
    );
  }
}
