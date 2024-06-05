import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/styles/custom_textstyle.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 7.w),
      child: Text(
        title,
        style: CustomTextStyle.headlineTextStyle.apply(fontSizeFactor: 0.8),
      ),
    );
  }
}
