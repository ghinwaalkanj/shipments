import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/id_upload_screen.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';
import 'package:shipment_merchent_app/features/auth/screen/verification_screen.dart';
import 'package:shipment_merchent_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:sizer/sizer.dart';

import 'bindings/intialbindings.dart';
import 'features/Qr_code/screen/Qr_code_display_screen.dart';
import 'features/Qr_code/screen/Qr_code_scan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        home: OnBoardingScreen(),
      );
    }
    );
  }
}
