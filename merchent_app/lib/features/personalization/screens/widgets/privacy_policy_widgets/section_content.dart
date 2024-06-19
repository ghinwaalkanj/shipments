import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';

class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          content,
          style: CustomTextStyle.greyTextStyle.apply(
            fontSizeFactor: 1.0,
            fontWeightDelta: 0,
          ),
          textAlign: TextAlign.justify,
        ),
        CustomSizedBox.itemSpacingVertical(height: 1.h),
      ],
    );
  }
}
