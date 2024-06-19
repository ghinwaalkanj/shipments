import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 42.h,
      right: 2.w,
      child: Text(
        "رقم الموبايل",
        style: TextStyle(
            fontSize: 12.sp,
            color: TColors.primary,
            fontWeight: FontWeight.w600,
            fontFamily: "Cairo"),
      ),);
  }
}
