import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/paddings.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    required this.height,
     this.width,
    this.child, this.padding,
  });

  final double height;
  final double? width;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      padding:padding ,
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Padding(
        padding: TPadding.widgetPadding,
        child: child,
      ),
    );
  }
}
