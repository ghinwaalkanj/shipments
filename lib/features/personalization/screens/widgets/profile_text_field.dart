import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class ProfileTextField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final bool isEnabled;

  const ProfileTextField({
    Key? key,
    required this.initialValue,
    required this.labelText,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: isEnabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          color: TColors.primary
        ),
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
