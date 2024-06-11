import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:shipment_merchent_app/utils/helpers/ThemeController.dart';
import 'package:sizer/sizer.dart';
import 'bindings/intialbindings.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: OnBoardingScreen(),
      );
    }
    );
  }
}
