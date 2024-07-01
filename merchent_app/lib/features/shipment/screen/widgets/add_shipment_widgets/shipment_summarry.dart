import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controller/add_shipment_controller.dart';

class ShipmentSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddShipmentController controller = Get.find();
    final TextEditingController feeController = TextEditingController();

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
                    '${controller.shipmentValue.value} JD',
                    style: CustomTextStyle.greyTextStyle
                        .apply(color: Colors.black),
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
              GestureDetector(
                onTap: () {
                  feeController.text =
                      double.parse(controller.shipmentFee.value)
                          .toStringAsFixed(1);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'تعديل تكاليف الشحن',
                          textAlign: TextAlign.right,
                          style: CustomTextStyle.headlineTextStyle,
                        ),
                        content: TextField(
                          cursorOpacityAnimates: true,
                          cursorColor: TColors.primary,
                          controller: feeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "أدخل تكاليف الشحن الجديدة",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: TColors.primary),
                            ),
                            hintTextDirection: TextDirection.rtl,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'إلغاء',
                              style: CustomTextStyle.greyTextStyle,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              'حفظ',
                              style: CustomTextStyle.greyTextStyle
                                  .apply(color: TColors.primary),
                            ),
                            onPressed: () {
                              final newFee = double.tryParse(
                                      feeController.text) ??
                                  double.parse(controller.shipmentFee.value);
                              if (newFee >=
                                  double.parse(controller.shipmentFee.value)) {
                                controller.shipmentFee.value =
                                    newFee.toString();
                                Navigator.of(context).pop();
                              } else {
                                Get.snackbar(
                                  'خطأ',
                                  '',
                                  backgroundColor: TColors.error,
                                  colorText: TColors.white,
                                  snackPosition: SnackPosition.TOP,
                                  margin: EdgeInsets.all(10),
                                  borderRadius: 10,
                                  icon: Icon(Icons.error_outline,
                                      color: TColors.white),
                                  messageText: Text(
                                    'القيمة الجديدة يجب أن تكون أكبر من أو تساوي القيمة الحالية',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 10.sp,
                                      color: TColors.white,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Obx(
                      () => Text(
                        '${controller.shipmentFee.value.isEmpty ? '0.0' : double.parse(controller.shipmentFee.value).toStringAsFixed(1)} JD',
                        style: CustomTextStyle.greyTextStyle
                            .apply(color: Colors.black),
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      color: TColors.primary,
                      size: 12.sp,
                    ),
                  ],
                ),
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
              Obx(() {
                final shipmentValue =
                    double.tryParse(controller.shipmentValue.value) ?? 0.0;
                final shipmentFee =
                    double.tryParse(controller.shipmentFee.value) ?? 0.0;
                return Text(
                  '${double.parse('${shipmentValue + shipmentFee}').toStringAsFixed(1)} JD',
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
