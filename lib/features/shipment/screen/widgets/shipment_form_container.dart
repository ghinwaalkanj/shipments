import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/widgets/custom_shapes/containers/common_container.dart';

class ShipmentFormContainer extends StatelessWidget {
  final List<Widget> children;

  const ShipmentFormContainer({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      height: 45.h,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
      child: Column(children: children),
    );
  }
}