import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';

class AboutSectionTitle extends StatelessWidget {
  final String title;

  const AboutSectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CustomTextStyle.headlineTextStyle.apply(
            color: TColors.primary,
            fontSizeFactor: 1.2,
            fontWeightDelta: 2,
          ),
        ),
        CustomSizedBox.textSpacingVertical(),
      ],
    );
  }
}
