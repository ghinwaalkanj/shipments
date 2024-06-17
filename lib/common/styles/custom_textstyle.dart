import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants/colors.dart';


class CustomTextStyle {
  static TextStyle headlineTextStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 13.sp,
    color: TColors.black,
    fontWeight: FontWeight.w700,
  );
  static TextStyle greyTextStyle = TextStyle(
    color: TColors.textGrey,
    fontWeight: FontWeight.bold,
    fontSize: 9.sp,
    fontFamily: 'Cairo',
  );
  static TextStyle primaryTextStyle = TextStyle(
    color: TColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: 9.sp,
    fontFamily: 'Cairo',
  );
}
