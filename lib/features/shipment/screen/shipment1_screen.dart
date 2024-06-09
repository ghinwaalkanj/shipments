import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bottom_navigation_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipment_form_container.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/app_bar.dart';
import '../../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../controller/shipment_controller.dart';
import 'widgets/shipment_heading.dart';
import 'widgets/shipment_text_field.dart';

class ShipmentStep1Screen extends StatelessWidget {
  ShipmentStep1Screen({Key? key}) : super(key: key);

  final ShipmentController controller = Get.put(ShipmentController());
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController recipientAddressController = TextEditingController();
  final TextEditingController recipientPhoneController = TextEditingController();
  final TextEditingController shipmentNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'إضافة شحنة',
        showBackArrow: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShipmentHeading(
                    title: 'معلومات المستلم',
                    subtitle: 'التالي : معلومات الشحنة',
                    currentStep: 1,
                  ),
                  ShipmentFormContainer(
                    children: [
                      ShipmentTextField(
                        hintText: 'الاسم الكامل للعميل',
                        icon: Icons.person,
                        controller: recipientNameController,
                      ),
                      CustomSizedBox.itemSpacingVertical(),
                      ShipmentTextField(
                        hintText: 'عنوان تسليم الشحنة',
                        icon: Icons.location_on,
                        controller: recipientAddressController,
                      ),
                      CustomSizedBox.itemSpacingVertical(),
                      ShipmentTextField(
                        hintText: 'رقم هاتف العميل',
                        icon: Icons.phone,
                        controller: recipientPhoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      CustomSizedBox.itemSpacingVertical(),
                      ShipmentTextField(
                        hintText: 'ملاحظات إضافية (اختياري)',
                        icon: Icons.note,
                        controller: shipmentNoteController,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigationContainer(
                onNext: () {
                  controller.recipientName.value = recipientNameController.text;
                  controller.recipientAddress.value = recipientAddressController.text;
                  controller.recipientPhone.value = recipientPhoneController.text;
                  controller.shipmentNote.value = shipmentNoteController.text;
                  controller.nextStep();
                },
                onPrevious: controller.previousStep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
