import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/animation_controller.dart';
import '../../../controller/verify_controller.dart';

class PinputWidget extends StatelessWidget {
  const PinputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifyController verifyController = Get.find();
    final AnimationShakeController animationShakeController = Get.find();

    return Form(
      key: verifyController.formKey,
      child: SlideTransition(
        position: animationShakeController.offsetAnimation,
        child: Pinput(
          length: 5,
          controller: verifyController.pinController,
          focusNode: verifyController.focusNode,
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          listenForMultipleSmsOnAndroid: true,
          separatorBuilder: (index) => const SizedBox(width: 8),
          validator: (value) {
            if (value == verifyController.verificationCode.toString()) {
              return null;
            } else {
              animationShakeController.startShakeAnimation();
              return 'رمز التحقق غير صحيح';
            }
          },
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: (pin) {
            debugPrint('onCompleted: $pin');
          },
          onChanged: (value) {
            debugPrint('onChanged: $value');
            verifyController.updateCode(value);
          },
          defaultPinTheme: PinTheme(
            width: 13.w,
            height: 6.h,
            textStyle: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: TColors.primary),
            ),
          ),
          errorPinTheme: PinTheme(
            width: 13.w,
            height: 6.h,
            textStyle: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.red),
            ),
          ),
          errorTextStyle: TextStyle(
            color: Colors.red,
            fontSize: 11.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 9),
                width: 22,
                height: 1,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
