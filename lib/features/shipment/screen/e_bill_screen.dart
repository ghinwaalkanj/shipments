import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bottom_navigation_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/shipment_heading.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/summarry_container.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/shipment_controller.dart';

class EBillScreen extends StatelessWidget {
  const EBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ShipmentController controller = Get.find<ShipmentController>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'الإيصال الإلكتروني',
        showBackArrow: false,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShipmentHeading(
                    title: 'ملخص الشحنة',
                    currentStep: 3,
                  ),
                  const SectionTitle(title: 'ملخص التاجر'),
                  Obx(() => SummaryContainer(data: traderSummaryData(controller))),
                  const SectionTitle(title: 'ملخص المستلم'),
                  SummaryContainer(data: recipientSummaryData(controller)),
                  const SectionTitle(title: 'ملخص الشحنة'),
                  SummaryContainer(data: shipmentSummaryData(controller)),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigationContainer(
                onNext: controller.confirmShipment,
                onPrevious: controller.previousStep,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> traderSummaryData(ShipmentController controller) {
    return {
      'اسم التاجر': controller.merchantInfo.value.name,
      'المحافظة': 'دمشق', // يمكن تعديلها بناءً على البيانات المتاحة
      'العنوان': controller.merchantInfo.value.businessName,
      'رقم الهاتف': controller.merchantInfo.value.phone,
    };
  }

  Map<String, String> recipientSummaryData(ShipmentController controller) {
    return {
      'اسم المستلم': controller.recipientName.value,
      'المحافظة': 'دمشق', // يمكن تعديلها بناءً على البيانات المتاحة
      'العنوان': controller.recipientAddress.value,
      'رقم الهاتف': controller.recipientPhone.value,
    };
  }

  Map<String, String> shipmentSummaryData(ShipmentController controller) {
    return {
      'محتوى الشحنة': controller.shipmentContents.value,
      'سرعة الشحن': controller.shipmentType.value,
      'الوزن': '${controller.shipmentWeight.value} كغ',
      'العدد': '${controller.shipmentQuantity.value} قطعة',
      'السعر': '${controller.shipmentValue.value} \$',
      'تكاليف الشحن': '${controller.shipmentFee.value} \$',
      'ملاحظات': controller.shipmentNote.value.isEmpty ? '-' : controller.shipmentNote.value,
    };
  }
}
