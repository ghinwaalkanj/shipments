import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/shipment/screen/tracking_screen.dart';
import 'package:shipment_merchent_app/features/Qr_code/screen/Qr_code_display_screen.dart';
import 'package:shipment_merchent_app/features/home/controller/home_controller.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/stepper_widget.dart';

class CurrentShipmentsWidget extends StatelessWidget {
  const CurrentShipmentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الشحنات الحالية',
              style: CustomTextStyle.headlineTextStyle,
            ),
          ],
        ),
        CustomSizedBox.itemSpacingVertical(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.shipments.map((shipment) {
              return Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: GestureDetector(
                  onTap: () {
                    Get.to(TrackingScreen(
                      shipmentId: shipment.shipmentId!,
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    height: 30.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shipment.shipmentContents ?? '',
                                    style: CustomTextStyle.greyTextStyle,
                                  ),
                                  CustomSizedBox.textSpacingVertical(),
                                  Text(
                                    shipment.shipmentNumber ?? '',
                                    style: CustomTextStyle.headlineTextStyle.apply(
                                      fontSizeFactor: 0.65.sp,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (shipment.shipmentStatus == 3) {
                                    Get.to(QrCodeDisplayScreen(
                                      shipmentNumber: shipment.shipmentNumber!,
                                    ));
                                  }
                                },
                                child: Container(
                                  height: 5.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    color: TColors.primary,
                                    borderRadius: BorderRadius.circular(14.sp),
                                  ),
                                  child: Center(
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              controller.getShipmentStatusText(
                                                shipment.shipmentStatus!,
                                              ),
                                              style: CustomTextStyle.greyTextStyle.apply(
                                                color: controller.getShipmentStatusColor(
                                                  shipment.shipmentStatus!,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              controller.getShipmentStatusIcon(
                                                shipment.shipmentStatus!,
                                              ),
                                              color: controller.getShipmentStatusColor(
                                                shipment.shipmentStatus!,
                                              ),
                                              size: 14.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomSizedBox.itemSpacingVertical(height: 3),
                          StepperWidget(
                            status: shipment.shipmentStatus!,
                          ),
                          CustomSizedBox.itemSpacingVertical(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "من",
                                      style: CustomTextStyle.greyTextStyle.apply(
                                        color: TColors.grey,
                                      ),
                                    ),
                                    CustomSizedBox.textSpacingVertical(),
                                    Text(
                                      shipment.fromCityName ?? '',
                                      style: CustomTextStyle.headlineTextStyle.apply(
                                        fontSizeFactor: 0.65.sp,
                                      ),
                                    ),
                                    CustomSizedBox.textSpacingVertical(),
                                    Text(
                                      shipment.shipmentCreatedAt!.split(' ')[0],
                                      style: CustomTextStyle.greyTextStyle.apply(
                                        fontSizeFactor: 0.8.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FittedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      "إلى",
                                      style: CustomTextStyle.greyTextStyle.apply(
                                        color: TColors.grey,
                                      ),
                                    ),
                                    CustomSizedBox.textSpacingVertical(),
                                    Text(
                                      shipment.recipientCity ?? '',
                                      style: CustomTextStyle.headlineTextStyle.apply(
                                        fontSizeFactor: 0.65.sp,
                                      ),
                                    ),
                                    CustomSizedBox.textSpacingVertical(),
                                    Text(
                                      shipment.estimatedDeliveryTime!.split(' ')[0],
                                      style: CustomTextStyle.greyTextStyle.apply(
                                        fontSizeFactor: 0.8.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
