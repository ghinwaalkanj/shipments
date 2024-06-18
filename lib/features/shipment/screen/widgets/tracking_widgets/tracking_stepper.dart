import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../Qr_code/screen/Qr_code_display_screen.dart';

class TrackingStepper extends StatelessWidget {
  final int status;
  final String? subtitle;
  final String? shipmentNumber;

  TrackingStepper({required this.status, this.subtitle, this.shipmentNumber});

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
      {'title': 'المندوب بالقرب منك', 'subtitle': 'تفاصيل الخطوة 2'},
      {'title': 'تم تسليم الشحنة للمندوب', 'subtitle': 'تفاصيل الخطوة 3'},
      {'title': 'في الطريق للزبون', 'subtitle': 'تفاصيل الخطوة 4'},
      {'title': 'المندوب بالقرب من الزبون', 'subtitle': 'تفاصيل الخطوة 4'},
      {'title': 'تم التسليم للزبون', 'subtitle': 'تفاصيل الخطوة 5'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                          color: status >= stepIndex - 1
                              ? TColors.primary
                              : TColors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: status >= stepIndex - 1
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(steps[index]['title']!,
                              style: CustomTextStyle.headlineTextStyle.apply(
                                  fontSizeDelta: -2.sp,
                                  color: TColors.primary)),
                          Text(
                            subtitle == null ? '' : subtitle!,
                            style: CustomTextStyle.greyTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      steps[index]['title'] == 'المندوب بالقرب منك'
                          ? IconButton(
                              color: status == 3?TColors.primary:TColors.buttonDisabled,
                              onPressed: () {
                                steps[index]['title'] == 'المندوب بالقرب منك' &&
                                        status == 3
                                    ? Get.to(QrCodeDisplayScreen(
                                        shipmentNumber: shipmentNumber!,
                                      ))
                                    : null;
                              },
                              icon: Icon(Icons.qr_code),
                            )
                          : SizedBox(),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
