import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/bottom_navigation_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/shipment_heading.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/add_shipment_widgets/summarry_container.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/add_shipment_controller.dart';

class ShipmentStep3Screen extends StatelessWidget {
  ShipmentStep3Screen({Key? key}) : super(key: key);

  final AddShipmentController controller = Get.find<AddShipmentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  onNext: (){
                    controller.confirmShipment();
                    controller.currentStep++;
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

  Map<String, String> traderSummaryData(AddShipmentController controller) {
    return {
      'اسم التاجر': controller.merchantInfo.value.name,
      'المحافظة':controller.merchantInfo.value.cityName! ,
      'العنوان': controller.merchantInfo.value.AddressDetails!,
      'رقم الهاتف': controller.merchantInfo.value.phone,
    };
  }

  Map<String, String> recipientSummaryData(AddShipmentController controller) {
    return {
      'اسم المستلم': controller.recipientName.value,
      'المحافظة': controller.recipientCity.value,
      'العنوان': controller.recipientAddress.value,
      'رقم الهاتف': '+962 7 ${controller.recipientPhone.value}',
    };
  }

  Map<String, String> shipmentSummaryData(AddShipmentController controller) {
    return {
      'محتوى الشحنة': controller.shipmentContents.value,
      'سرعة الشحن': controller.shipmentType.value,
      'الوزن': '${controller.shipmentWeight.value} كغ',
      'العدد': '${controller.shipmentQuantity.value} قطعة',
      'السعر': '${controller.shipmentValue.value} JD',
      'تكاليف الشحن': '${double.parse(controller.shipmentFee.value).toStringAsFixed(1)} JD',
      'ملاحظات': controller.shipmentNote.value.isEmpty ? '-' : controller.shipmentNote.value,
    };
  }
}

