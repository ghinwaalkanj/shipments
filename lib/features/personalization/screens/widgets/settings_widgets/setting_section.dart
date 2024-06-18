import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

class CustomSettingsSection extends StatelessWidget {
  final List<Widget> children;

  const CustomSettingsSection({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: children
            .map((child) => Column(
          children: [
            child,
            if (children.last != child) Divider(color: TColors.grey),
          ],
        ))
            .toList(),
      ),
    );
  }
}
