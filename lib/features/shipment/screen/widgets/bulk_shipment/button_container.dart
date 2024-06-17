import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

import '../../../controller/bulk_shipments_controller.dart';

class ButtonContainer extends StatelessWidget {
  final AddBulkShipmentController controller;

  ButtonContainer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 13.h,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 90.w,
              height: 7.h,
              child: ElevatedButton(
                onPressed: () {
                  controller.printShipmentData();
                  controller.submitShipments();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('إضافة الشحنات',
                    style: CustomTextStyle.greyTextStyle.apply(color: TColors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
