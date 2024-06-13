import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class TrackingStepper extends StatelessWidget {
  final int status;

  TrackingStepper({required this.status});

  Color getColor(int index) {
    if (status == 0) return TColors.grey;
    if (status >= index) return TColors.primary;
    return TColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(6, (index) {
          int stepIndex = index + 1;
          return Column(
            children: [
              Container(
                width: 24.sp,
                height: 24.sp,
                decoration: BoxDecoration(
                  color: status >= stepIndex ? TColors.primary : TColors.grey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: status >= stepIndex
                      ? Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16.sp,
                  )
                      : Container(),
                ),
              ),
              if (stepIndex != 6)
                Container(
                  width: 2,
                  height: 4.h,
                  color: getColor(stepIndex + 1),
                ),
            ],
          );
        }),
      ),
    );
  }
}
