import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bottom_navigation_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipment_detail_form.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipment_summarry.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/app_bar.dart';
import '../../../utils/constants/colors.dart';
import '../controller/shipment_controller.dart';
import 'widgets/shipment_heading.dart';

class ShipmentStep2Screen extends StatelessWidget {
  ShipmentStep2Screen({Key? key}) : super(key: key);
  final ShipmentController controller = Get.find<ShipmentController>();
  final TextEditingController shipmentTypeController = TextEditingController();
  final TextEditingController shipmentWeightController = TextEditingController();
  final TextEditingController shipmentQuantityController = TextEditingController();
  final TextEditingController shipmentValueController = TextEditingController();

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
                    title: 'معلومات الشحنة',
                    subtitle: 'التالي : ملخص الشحنة',
                    currentStep: 2,
                  ),
                  ShipmentDetailsForm(
                    shipmentTypeController: shipmentTypeController,
                    shipmentWeightController: shipmentWeightController,
                    shipmentQuantityController: shipmentQuantityController,
                    shipmentValueController: shipmentValueController,
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
                  controller.shipmentType.value = shipmentTypeController.text;
                  controller.shipmentWeight.value = (shipmentWeightController.text) ?? "1.0";
                  controller.shipmentQuantity.value = (shipmentQuantityController.text) ?? "1";
                  controller.shipmentValue.value = (shipmentValueController.text) ?? "555.0";
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