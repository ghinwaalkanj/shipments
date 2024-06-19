import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 4.h,
      right: TSizes.defaultSpace,
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
            shape:  CircleBorder(),
            backgroundColor:  TColors.primary ),
        child: const Icon(Iconsax.arrow_right_3,color:TColors.white,),
      ),
    );
  }
}
