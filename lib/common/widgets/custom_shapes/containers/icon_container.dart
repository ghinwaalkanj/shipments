import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10.h,
        width: 10.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: TColors.grey.withOpacity(0.5)),
        child: Icon(icon, color: Colors.teal));
  }
}
