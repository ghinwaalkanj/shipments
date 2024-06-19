import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import '../../../controller/bulk_shipments_controller.dart';

class ButtonContainer extends StatelessWidget {
  final AddBulkShipmentController controller;

  ButtonContainer({required this.controller});

  void showShipmentSummaryDialog(BuildContext context) {
    double totalAmount = 0;
    double totalDeliveryFee = 0;

    for (var i = 0; i < controller.shipmentForms.length; i++) {
      double amount =
          double.tryParse(controller.amountControllers[i].text) ?? 0;
      double fee = double.tryParse(controller.feeControllers[i].text) ?? 0;
      totalAmount += amount;
      totalDeliveryFee += fee;
    }

    double total = totalAmount + totalDeliveryFee;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ملخص الشحنات',
              textAlign: TextAlign.center,
              style: CustomTextStyle.headlineTextStyle
                  .apply(color: TColors.primary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ' JD سعر التوصيل الكلي: ${totalDeliveryFee.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                ' JD مبالغ الشحنات الكلية: ${totalAmount.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                ' JD الصافي: ${total.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'إلغاء',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 15.w,),
            ElevatedButton(
              onPressed: () {
                controller.printShipmentData();
                controller.submitShipments();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'تأكيد',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void validateAndShowDialog(BuildContext context) {
    bool allFieldsValid = true;

    for (var i = 0; i < controller.shipmentForms.length; i++) {
      if (controller.recipientNameControllers[i].text.isEmpty ||
          controller.phoneControllers[i].text.isEmpty ||
          controller.amountControllers[i].text.isEmpty ||
          controller.feeControllers[i].text.isEmpty) {
        allFieldsValid = false;
        break;
      }
    }

    if (allFieldsValid) {
      showShipmentSummaryDialog(context);
    } else {
      Get.snackbar(
        'خطأ',
        'يرجى تعبئة جميع الحقول المطلوبة',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

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
                  validateAndShowDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('إضافة الشحنات',
                    style: CustomTextStyle.greyTextStyle
                        .apply(color: TColors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
