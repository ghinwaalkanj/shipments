import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/styles/custom_textstyle.dart';
import '../../../../common/widgets/custom_sized_box.dart';
import '../../../../utils/constants/colors.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 7.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.textSpacingVertical(height: 0.5.h),
          Text(
            title,
            style: CustomTextStyle.headlineTextStyle.apply(
              fontSizeFactor: 1.0,
              fontWeightDelta: 1,
            ),
          ),
          CustomSizedBox.textSpacingVertical(),
        ],
      ),
    );
  }
}
