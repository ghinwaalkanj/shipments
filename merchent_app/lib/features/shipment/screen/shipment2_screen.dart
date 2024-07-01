import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/bottom_navigation_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/shipment_summarry.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/app_bar.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../utils/constants/colors.dart';
import '../controller/add_shipment_controller.dart';
import 'widgets/add_shipment_widgets/shipment_heading.dart';
import 'widgets/add_shipment_widgets/shipment_text_field.dart';
import '../../../../common/widgets/custom_sized_box.dart';

class ShipmentStep2Screen extends StatelessWidget {
  ShipmentStep2Screen({Key? key}) : super(key: key);
  final AddShipmentController controller = Get.find<AddShipmentController>();
  final TextEditingController shipmentWeightController =
      TextEditingController();
  final TextEditingController shipmentQuantityController =
      TextEditingController();
  final TextEditingController shipmentValueController = TextEditingController();
  final TextEditingController shipmentFeeController = TextEditingController();
  final TextEditingController shipmentContentsController =
      TextEditingController();
  final TextEditingController shipmentNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with current values
    shipmentWeightController.text = controller.shipmentWeight.value.isEmpty
        ? ''
        : controller.shipmentWeight.value;
    shipmentQuantityController.text = controller.shipmentQuantity.value.isEmpty
        ? ''
        : controller.shipmentQuantity.value;
    shipmentValueController.text = controller.shipmentValue.value.isEmpty
        ? ''
        : controller.shipmentValue.value;
    shipmentFeeController.text = controller.shipmentFee.value.isEmpty
        ? ''
        : controller.shipmentFee.value;
    shipmentContentsController.text = controller.shipmentContents.value.isEmpty
        ? ''
        : controller.shipmentContents.value;
    shipmentNoteController.text = controller.shipmentNote.value.isEmpty
        ? ''
        : controller.shipmentNote.value;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'إضافة شحنة',
        showBackArrow: false,
      ),
      body: WillPopScope(
        onWillPop: () async {
          controller.previousStep();
          return false;
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 22.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShipmentHeading(
                      title: 'معلومات الشحنة',
                      subtitle: 'التالي : ملخص الشحنة',
                      currentStep: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        children: [
                          ShipmentTextField(
                            hintText: 'مبلغ مقدم الشحنة',
                            icon: Icons.attach_money,
                            controller: shipmentValueController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              controller.shipmentValue.value = value;
                            },
                          ),
                          CustomSizedBox.itemSpacingVertical(),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  if (controller.shippingTypes.isEmpty) {
                                    return Center(child: CircularProgressIndicator()); // Show loading indicator if shipping types are not loaded yet
                                  } else {
                                    return DropdownButtonFormField<String>(
                                      value: controller.shipmentType.value.isEmpty ? null : controller.shipmentType.value,
                                      items: controller.shippingTypes.map((shippingType) {
                                        return DropdownMenuItem<String>(
                                          value: shippingType.type,
                                          child: Text(
                                            shippingType.type,
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: TColors.darkGrey,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.shipmentType.value = value!;
                                        final selectedShippingType = controller.shippingTypes.firstWhere((type) => type.type == value);
                                        controller.selectedShippingTypeId.value = selectedShippingType.id; // حفظ الـ ID
                                      },
                                      decoration: InputDecoration(
                                        hintText: "سرعة الشحن",
                                        hintStyle: CustomTextStyle.greyTextStyle,
                                        prefixIcon: Icon(
                                          Icons.speed_outlined,
                                          color: TColors.primary,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.sp),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.sp),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.sp),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: TColors.grey.withOpacity(0.2),
                                      ),
                                      icon: Icon(Icons.arrow_drop_down, textDirection: TextDirection.ltr),
                                    );
                                  }
                                }),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: ShipmentTextField(
                                  hintText: 'محتوى الشحنة',
                                  icon: Icons.description,
                                  controller: shipmentContentsController,
                                  onChanged: (value) {
                                    controller.shipmentContents.value = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          CustomSizedBox.itemSpacingVertical(),
                          Row(
                            children: [
                              Expanded(
                                child: ShipmentTextField(
                                  hintText: 'وزن الشحنة (كغ)',
                                  icon: Icons.line_weight,
                                  controller: shipmentWeightController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.shipmentWeight.value = value;
                                  },
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: ShipmentTextField(
                                  hintText: 'الكمية',
                                  icon: Icons.format_list_numbered,
                                  controller: shipmentQuantityController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.shipmentQuantity.value = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          CustomSizedBox.itemSpacingVertical(),
                          ShipmentTextField(
                            hintText: 'ملاحظات إضافية (اختياري)',
                            icon: Icons.note,
                            controller: shipmentNoteController,
                            onChanged: (value) {
                              controller.shipmentNote.value = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ShipmentSummary(),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomNavigationContainer(
                  onNext: () {
                    if (shipmentValueController.text.isEmpty ||
                        controller.shipmentType.value.isEmpty ||
                        shipmentWeightController.text.isEmpty ||
                        shipmentQuantityController.text.isEmpty ||
                        shipmentContentsController.text.isEmpty) {
                      Get.snackbar(
                        'خطأ',
                        'يرجى ملء جميع الحقول ',
                        backgroundColor: TColors.error,
                        colorText: TColors.white,
                        snackPosition: SnackPosition.TOP,
                        margin: EdgeInsets.all(10),
                        borderRadius: 10,
                        icon: Icon(Icons.error_outline, color: TColors.white),
                      );
                    } else {
                      controller.shipmentWeight.value =
                          shipmentWeightController.text.isEmpty
                              ? "1.0"
                              : shipmentWeightController.text;
                      controller.shipmentQuantity.value =
                          shipmentQuantityController.text.isEmpty
                              ? "1"
                              : shipmentQuantityController.text;
                      controller.shipmentValue.value =
                          shipmentValueController.text.isEmpty
                              ? "0"
                              : shipmentValueController.text;
                      controller.shipmentContents.value =
                          shipmentContentsController.text.isEmpty
                              ? 'غير محدد'
                              : shipmentContentsController.text;
                      controller.shipmentNote.value =
                          shipmentNoteController.text;
                      controller.shipmentType.value =
                          controller.shipmentType.value;
                      controller.calculateShippingFee();
                      controller.nextStep();
                    }
                  },
                  onPrevious: controller.previousStep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
