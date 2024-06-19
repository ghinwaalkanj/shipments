import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';

class AboutSectionLogo extends StatelessWidget {
  const AboutSectionLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSizedBox.itemSpacingVertical(height: 1.h),
        Center(
          child: Image.asset(
            'assets/images/logo.png', // تأكد من وجود الصورة في مجلد assets
            height: 20.h,
            width: 20.h,
          ),
        ),
        CustomSizedBox.itemSpacingVertical(height: 1.h),
      ],
    );
  }
}
