import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/styles/custom_textstyle.dart';
import '../../../../common/widgets/custom_sized_box.dart';
import '../../../../utils/constants/colors.dart';
import '../../controller/shipment_controller.dart';

class ShipmentSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ShipmentController controller = Get.find();

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
              Obx(() => Text(
                '${controller.shipmentValue.value} \$',
                style: CustomTextStyle.greyTextStyle.apply(color: Colors.black),
              )),
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
              Obx(() => Row(
                children: [
                  Text(
                    '${controller.shipmentFee.value} \$',
                    style: CustomTextStyle.greyTextStyle.apply(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Icon(
                      Icons.edit,
                      color: TColors.primary,
                      size: 12.sp,
                    ),
                  ),
                ],
              )),
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
              Obx(() {
                final shipmentValue = double.tryParse(controller.shipmentValue.value) ?? 0.0;
                final shipmentFee = double.tryParse(controller.shipmentFee.value) ?? 0.0;
                return Text(
                  '${shipmentValue + shipmentFee} \$',
                  style: CustomTextStyle.headlineTextStyle
                      .apply(color: TColors.primary, fontSizeFactor: 0.9),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
