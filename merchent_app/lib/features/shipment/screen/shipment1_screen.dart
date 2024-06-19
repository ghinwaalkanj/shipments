import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/shipment/screen/recipent_map_address_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/bottom_navigation_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/shipment_form_container.dart';
import 'package:shipment_merchent_app/navigation_menu.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/app_bar.dart';
import '../../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import '../controller/add_shipment_controller.dart';
import 'widgets/add_shipment_widgets/shipment_heading.dart';
import 'widgets/add_shipment_widgets/shipment_text_field.dart';

class ShipmentStep1Screen extends StatelessWidget {
  ShipmentStep1Screen({Key? key}) : super(key: key);

  final AddShipmentController controller = Get.put(AddShipmentController());
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController recipientAddressController = TextEditingController();
  final TextEditingController recipientPhoneController = TextEditingController();
  final TextEditingController shipmentNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Use temporary fields if they are set, otherwise use permanent fields
    recipientNameController.text = controller.tempRecipientName.value.isNotEmpty ? controller.tempRecipientName.value : controller.recipientName.value;
    if (controller.recipientCity.value.isNotEmpty && controller.recipientAddress.value.isNotEmpty) {
      recipientAddressController.text = "${controller.recipientCity.value} - ${controller.recipientAddress.value}";
    } else if (controller.recipientAddress.value.isNotEmpty) {
      recipientAddressController.text = controller.recipientAddress.value;
    } else {
      recipientAddressController.text = controller.recipientCity.value;
    }
    recipientPhoneController.text = controller.tempRecipientPhone.value.isNotEmpty ? controller.tempRecipientPhone.value : controller.recipientPhone.value;
    shipmentNoteController.text = controller.tempShipmentNote.value.isNotEmpty ? controller.tempShipmentNote.value : controller.shipmentNote.value;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'إضافة شحنة',
        showBackArrow: false,
        showSwitch: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.to(() => NavigationMenu());
          return false;
        },
        child: Directionality(
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
                          onChanged: (value) {
                            controller.tempRecipientName.value = value;
                          },
                        ),
                        CustomSizedBox.itemSpacingVertical(),
                        ShipmentTextField(
                          hintText: 'عنوان تسليم الشحنة',
                          showCursor: false,
                          icon: Icons.location_on,
                          controller: recipientAddressController,
                          onTap: () {
                            controller.tempRecipientName.value = recipientNameController.text;
                            controller.tempRecipientPhone.value = recipientPhoneController.text;
                            controller.tempShipmentNote.value = shipmentNoteController.text;
                            Get.to(() => RecipentMapAddressScreen());
                          },
                        ),
                        CustomSizedBox.itemSpacingVertical(),
                        ShipmentTextField(
                          hintText: 'رقم هاتف العميل',
                          icon: Icons.phone,
                          controller: recipientPhoneController,
                          keyboardType: TextInputType.phone,
                          isJordanianNumber: true,
                          onChanged: (value) {
                            controller.tempRecipientPhone.value = value;
                          },
                        ),
                        CustomSizedBox.itemSpacingVertical(),
                        ShipmentTextField(
                          hintText: 'ملاحظات إضافية (اختياري)',
                          icon: Icons.note,
                          controller: shipmentNoteController,
                          onChanged: (value) {
                            controller.tempShipmentNote.value = value;
                          },
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
                    controller.recipientAddress.value = recipientAddressController.text.split('-').last.trim();
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
      ),
    );
  }
}
