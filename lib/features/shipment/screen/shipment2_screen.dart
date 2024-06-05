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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  ShipmentDetailsForm(),
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
                onNext: controller.nextStep,
                onPrevious: controller.previousStep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



