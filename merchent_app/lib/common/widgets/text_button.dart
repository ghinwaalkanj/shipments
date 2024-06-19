import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants/colors.dart';

class TTextButton extends StatelessWidget {
  const TTextButton({
    super.key, required this.text, this.onPressed,
  });
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          color: TColors.primary,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
