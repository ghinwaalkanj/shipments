import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../auth/screen/login_screen.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: TSizes.defaultSpace,
      top: TDeviceUtils.getAppBarHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          TextButton(
            onPressed: () => Get.to(LoginScreen()),
            child: const Text(
              "تخطي",
              style: TextStyle(
                color: TColors.grey,
                fontFamily: 'Cairo'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
