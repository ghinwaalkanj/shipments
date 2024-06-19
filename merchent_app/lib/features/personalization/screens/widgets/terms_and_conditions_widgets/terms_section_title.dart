import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';

class TermsSectionTitle extends StatelessWidget {
  final String title;

  const TermsSectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedBox.textSpacingVertical(height: 0.5.h),
        Text(
          title,
          style: CustomTextStyle.headlineTextStyle.apply(
            color: TColors.primary,
            fontSizeFactor: 1.0,
            fontWeightDelta: 1,
          ),
        ),
        CustomSizedBox.textSpacingVertical(),
      ],
    );
  }
}
