import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(
            'أضف صورة البطاقة الشخصية',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          'تأكد من ظهور صورة الوجه الأمامي والخلفي للبطاقة بشكل واضح وصحيح.',
          style: TextStyle(
            fontSize: 10.sp,
            color: TColors.darkGrey,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
