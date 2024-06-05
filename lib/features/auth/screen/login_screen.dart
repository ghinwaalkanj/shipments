import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/auth/screen/verification_screen.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/label_text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/logo_image.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/number_counter.dart';
import 'package:shipment_merchent_app/features/auth/screen/widgets/privacy_policy.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/button.dart';
import '../../../common/widgets/text_field.dart';
import '../../../utils/constants/colors.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Stack(
          children: [
            LogoImage(),
            LabelTextField(),
            Positioned(
              top: 47.h,
              child: TTextField(
                hintText: '-- --- --- 9 963+',
                suffixIcon: Icon(Icons.phone_android_outlined, color: TColors.primary, size: 19.sp),
                controller: phoneController,
              ),
            ),
            NumberCounter(),
            PrivacyPolicy(),
            Positioned(
                bottom: 10.h,
                left: 2.w,
                child: TButton( text: 'تسجيل دخول',onPressed: ()=>Get.to(VerifyScreen()),)),
          ],
        ),
      ),
    );
  }
}





