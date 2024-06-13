import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../controller/tracking_controller.dart';

class TrackingStepper extends StatelessWidget {
  final int status;
  final String? subtitle;

  TrackingStepper({required this.status,  this.subtitle});

  Color getColor(int index) {
    if (status == 0) return TColors.grey;
    if (status >= index) return TColors.primary;
    return TColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> steps = [
      {'title': 'بانتظار القبول', 'subtitle': 'تفاصيل الخطوة 1'},
      {'title': 'تم قبول الشحنة', 'subtitle': 'تفاصيل الخطوة 1'},
      {'title': 'في الطريق إليك', 'subtitle': 'تفاصيل الخطوة 2'},
      {'title': 'تم تسليم الشحنة للمندوب', 'subtitle': 'تفاصيل الخطوة 3'},
      {'title': 'في الطريق للزبون', 'subtitle': 'تفاصيل الخطوة 4'},
      {'title': 'تم التسليم للزبون', 'subtitle': 'تفاصيل الخطوة 5'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(steps.length, (index) {
            int stepIndex = index + 1;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24.sp,
                      height: 24.sp,
                      decoration: BoxDecoration(
                        color: status >= stepIndex ? TColors.primary : TColors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: status >= stepIndex
                            ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.sp,
                        )
                            : Container(),
                      ),
                    ),
                    if (stepIndex != steps.length)
                      Container(
                        width: 2,
                        height: 4.h,
                        color: getColor(stepIndex + 1),
                      ),
                  ],
                ),
                SizedBox(width: 2.w),
                Column(
                  children: [
                    Text(
                      steps[index]['title']!,
                      style: CustomTextStyle.headlineTextStyle.apply(fontSizeDelta:-2.sp,color: TColors.primary)
                    ),
                    Text(
                      subtitle==null?'':subtitle!,
                      style:CustomTextStyle.greyTextStyle,
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
