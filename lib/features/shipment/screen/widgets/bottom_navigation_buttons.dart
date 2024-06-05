import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/common_container.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';
import '../../controller/shipment_controller.dart';

class BottomNavigationButtons extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback? onPrevious;
  final bool showPrevious;

  const BottomNavigationButtons({
    Key? key,
    required this.onNext,
    this.onPrevious,
    this.showPrevious = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShipmentController>();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Obx(() {
        bool showPrevious = controller.currentStep.value > 1;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showPrevious)
              SizedBox(
                width: showPrevious ? 25.w : 90.w,
                height: 7.h,
                child: ElevatedButton(
                  onPressed: onPrevious,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: TColors.primary, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'السابق',
                    style: TextStyle(
                      color: TColors.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: showPrevious ? 60.w : 90.w,
              height: 7.h,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                    'التالي',
                    style: CustomTextStyle.greyTextStyle.apply(
                        color: TColors.white)
                ),
              ),
            ),
          ],
        );
      }
      ),
    );
  }
}
