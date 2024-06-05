import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/styles/custom_textstyle.dart';
import '../../../../common/widgets/custom_sized_box.dart';
import '../../../../utils/constants/colors.dart';

class ShipmentSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'مبلغ الشحنة',
                style: CustomTextStyle.greyTextStyle.apply(color: Colors.black),
              ),
              Text(
                '200 \$',
                style: CustomTextStyle.greyTextStyle.apply(color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تكاليف الشحن',
                style: CustomTextStyle.greyTextStyle.apply(color: Colors.black),
              ),
              Row(
                children: [
                  Text(
                    '20 \$',
                    style:
                    CustomTextStyle.greyTextStyle.apply(color: Colors.black),
                  ),
                  Icon(
                    Icons.edit,
                    color: TColors.primary,
                    size: 12.sp,
                  )
                ],
              ),
            ],
          ),
          CustomSizedBox.textSpacingVertical(),
          Divider(
            thickness: 1.2,
            color: TColors.black,
          ),
          CustomSizedBox.textSpacingVertical(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الصافي',
                style: CustomTextStyle.headlineTextStyle
                    .apply(color: TColors.primary, fontSizeFactor: 0.9),
              ),
              Text(
                '220\$',
                style: CustomTextStyle.headlineTextStyle
                    .apply(color: TColors.primary, fontSizeFactor: 0.9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
