import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants/colors.dart';

class TButton extends StatelessWidget {
  const TButton({
    super.key, required this.text, this.onPressed,
  });
  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85.w,
      height: 7.h,
      child: MaterialButton(
        onPressed:onPressed,
        color: TColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.sp),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Cairo",
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
