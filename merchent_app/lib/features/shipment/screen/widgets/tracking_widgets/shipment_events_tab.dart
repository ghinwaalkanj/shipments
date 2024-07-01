import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/tracking_controller.dart';
import 'tracking_stepper.dart';

Widget ShipmentEventsTab(TrackingController controller) {
  final shipmentInfo = controller.shipmentInfo.value;
  final recipientInfo = controller.recipientInfo.value;
  final deliveryInfo = controller.deliveryInfo.value;


  void _showDeliveryInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (deliveryInfo['average_rating'] != null)
                    Row(
                      children: [
                        Text(
                          '${deliveryInfo['average_rating']}',
                          style: CustomTextStyle.headlineTextStyle,
                        ),
                        Icon(Icons.star, color: TColors.primary, size: 2.h),
                      ],
                    ),
                  if (deliveryInfo['average_rating'] == null)
                    Text(
                      'مبتدئ',
                      style: CustomTextStyle.headlineTextStyle,
                    ),
                  Expanded(child: SizedBox()), // Add Expanded here
                  Text(
                    deliveryInfo['name'],
                    style: CustomTextStyle.headlineTextStyle,
                  ),
                  SizedBox(width: 2.w), // Adjust the spacing if needed
                  Icon(Icons.account_circle, size: 8.h, color: TColors.primary),
                ],
              ),
              SizedBox(height: 2.h),
              Container(
                width: 100.w,
                child: Row(
                  children: [
                    Container(
                      height: 6.h, // Adjust the height to match the text field using Sizer
                      width: 12.w, // Adjust the width using Sizer
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius: BorderRadius.circular(1.h), // Adjusted border radius using Sizer
                      ),
                      child: IconButton(
                        icon: Icon(Icons.phone, color: Colors.white),
                        onPressed: () {
                          launchUrl(Uri.parse('tel:${deliveryInfo['phone']}'));
                        },
                      ),
                    ),
                    SizedBox(width: 2.w), // Adjusted spacing using Sizer
                    Container(
                      height: 6.h,
                      width: 50.w,
                      padding: EdgeInsets.symmetric(horizontal: 1.w), // Adjusted padding using Sizer
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.h), // Adjusted border radius using Sizer
                        border: Border.all(color: TColors.primary),
                      ),
                      child: Center( // Centered the text vertically
                        child: Text(
                          deliveryInfo['phone'],
                          style: CustomTextStyle.headlineTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
              style: CustomTextStyle.headlineTextStyle
                  .apply(color: TColors.darkGrey, fontWeightDelta: -10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )
          : TrackingStepper(
        status: shipmentInfo['shipment_status'],
        subtitle: '${recipientInfo['address']}',
        shipmentNumber: shipmentInfo['shipment_number'],
        onContactPressed: () => _showDeliveryInfoDialog(Get.context!),
      ),
    ),
  );
}
