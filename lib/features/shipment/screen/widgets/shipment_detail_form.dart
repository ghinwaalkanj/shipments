import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipment_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class ShipmentDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
      color: TColors.white,
      child: Column(
        children: [
          ShipmentTextField(
            hintText: 'مبلغ مقدم الشحنة',
            icon: Iconsax.moneys5,
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShipmentTextField(
                width: 42.w,
                hintText: 'محتوى الشحنة',
                icon: Iconsax.box,
              ),
              ShipmentTextField(
                width: 42.w,
                hintText: 'سرعة الشحن',
                icon: Iconsax.speedometer,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShipmentTextField(
                width: 42.w,
                hintText: 'الكمية',
                icon: Iconsax.box,
              ),
              ShipmentTextField(
                width: 42.w,
                hintText: 'وزن الشحنة',
                icon: Iconsax.weight_15,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ShipmentTextField(
            hintText: 'ملاحظات إضافية (اختياري)',
            icon: Iconsax.note,
          ),
        ],
      ),
    );
  }
}
