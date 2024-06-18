import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'المعلومات الشخصية',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          'مرحبا! قبل البدء، يُرجى إدخال معلوماتك الشخصية\nلتوثيق هويتك والوصول إلى خدماتنا بسهولة',
          style: TextStyle(
            fontSize: 10.sp,
            color: TColors.darkGrey,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
