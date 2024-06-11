import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      right: 2.w,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'بالضغط على تسجيل دخول , فإنك توافق على \n ',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: 'الأحكام و الشروط ',
              style: TextStyle(
                fontSize: 10.sp,
                color: TColors.primary,
                fontFamily: "Cairo",

                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(
              text: 'و ',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.black,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: 'سياسة الخصوصية\n والاستخدام.',
              style: TextStyle(
                fontSize: 10.sp,
                color: TColors.primary,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
