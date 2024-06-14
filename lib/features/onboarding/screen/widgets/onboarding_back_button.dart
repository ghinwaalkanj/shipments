import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../controller/onboarding_controller.dart';

class OnBoardingBackButton extends StatelessWidget {
  const OnBoardingBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: TSizes.defaultSpace,
      top: TDeviceUtils.getAppBarHeight(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back,color: TColors.primary),
            onPressed:()=>OnBoardingController.instance.previousPage(),
          ),
        ],
      ),
    );
  }
}
