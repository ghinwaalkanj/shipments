import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controller/verify_controller.dart';

class ResendCodeWidget extends StatelessWidget {
  const ResendCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VerifyController controller = Get.find();

    return Obx(
          () => Row(
        children: [
          controller.resendCountdown.value == 0
              ? TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: controller.resendCode,
            child: Center(
              child: Text(
                'إعادة إرسال رمز التحقق',
                style: TextStyle(
                  color: TColors.primary,
                  fontSize: 8.5.sp,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
              : Text(
            '. إعادة إرسال الرمز خلال${controller.resendCountdown.value} ثانية',
            style: TextStyle(
              color: TColors.grey,
              fontSize: 8.5.sp,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
