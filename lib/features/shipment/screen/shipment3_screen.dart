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

class ShipmentStep3Screen extends StatelessWidget {
  ShipmentStep3Screen({Key? key}) : super(key: key);

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
                    title: 'ملخص الشحنة',
                    currentStep: 3,
                  ),
                  const SectionTitle(title: 'ملخص التاجر'),
                  SummaryContainer(data: traderSummaryData),
                  const SectionTitle(title: 'ملخص المستلم'),
                  SummaryContainer(data: recipientSummaryData),
                  const SectionTitle(title: 'ملخص الشحنة'),
                  SummaryContainer(data: shipmentSummaryData),
                  SizedBox(height: 15.h),
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

  final Map<String, String> traderSummaryData = {
    'اسم المستلم': 'راما ملقط',
    'المحافظة': 'دمشق',
    'العنوان': 'زاهرة جديدة-شارع البرج',
    'رقم الهاتف': '09565598325',
    'ملاحظات': '-',
  };

  final Map<String, String> recipientSummaryData = {
    'اسم المستلم': 'راما ملقط',
    'المحافظة': 'دمشق',
    'العنوان': 'زاهرة جديدة-شارع البرج',
    'رقم الهاتف': '09565598325',
    'ملاحظات': '-',
  };

  final Map<String, String> shipmentSummaryData = {
    'نوع الشحنة': 'إلكترونيات',
    'الوزن': '5 كغ',
    'العدد': '24 قطعة',
    'السعر': '200 \$',
    'ملاحظات': '-',
  };
}
