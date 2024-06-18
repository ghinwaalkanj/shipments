import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';

class ProfileTextField extends StatelessWidget {
  final String? initialValue;
  final String labelText;
  final bool isEnabled;
  final TextEditingController? controller;

  const ProfileTextField({
    Key? key,
    this.initialValue,
    required this.labelText,
    this.isEnabled = true,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 13.sp,
      ),
      controller: controller,
      initialValue:initialValue,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            color: TColors.primary),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: TColors.primary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
