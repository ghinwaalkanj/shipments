import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';
import 'package:shipment_merchent_app/features/onboarding/controller/onboarding_controller.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:shipment_merchent_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:sizer/sizer.dart';
import 'core/integration/crud.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Crud());
  final OnBoardingController onBoardingController = Get.put(OnBoardingController());
  await onBoardingController.checkIfFirstTime();
  runApp(MyApp(onBoardingController: onBoardingController));
}

class MyApp extends StatelessWidget {
  final OnBoardingController onBoardingController;
  MyApp({required this.onBoardingController});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
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
