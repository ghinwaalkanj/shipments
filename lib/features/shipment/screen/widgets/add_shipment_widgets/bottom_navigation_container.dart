import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import 'bottom_navigation_buttons.dart';
//
class BottomNavigationContainer extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const BottomNavigationContainer({
    Key? key,
    required this.onNext,
    required this.onPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 13.h,
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp),bottom: Radius.circular(20.sp)),
      ),
      child: BottomNavigationButtons(
        onNext: onNext,
        onPrevious: onPrevious,
      ),
    );
  }
}
