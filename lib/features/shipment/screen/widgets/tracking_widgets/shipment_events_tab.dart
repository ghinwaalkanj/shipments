import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/tracking_controller.dart';
import 'tracking_stepper.dart';

Widget ShipmentEventsTab(TrackingController controller) {
  final shipmentInfo = controller.shipmentInfo.value;
  final recipientInfo = controller.recipientInfo.value;
  return Padding(
    padding: EdgeInsets.only(top: 3.h),
    child: Align(
      alignment: Alignment.topRight,
      child: controller.shipmentInfo.value['shipment_status'] == 10
          ? ListView(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 5.h),
          Center(
            child: Image(
              image: AssetImage("assets/images/canceled.png"),
              height: 20.h,
            ),
          ),
          CustomSizedBox.itemSpacingVertical(height: 0.5.h),
          Center(
            child: Text(
              'تم إلغاء الشحنة',
              style: CustomTextStyle.headlineTextStyle,
            ),
          ),
          CustomSizedBox.textSpacingVertical(),
          Center(
            child: Text(
              'لم يعد بالإمكان تتبع الشحنة حيث تم إلغاؤها',
              style: CustomTextStyle.headlineTextStyle.apply(color: TColors.darkGrey, fontWeightDelta: -10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )
          : TrackingStepper(
        status: shipmentInfo['shipment_status'],
        subtitle: '${recipientInfo['address']}',
        shipmentNumber: shipmentInfo['shipment_number'],
      ),
    ),
  );
}
