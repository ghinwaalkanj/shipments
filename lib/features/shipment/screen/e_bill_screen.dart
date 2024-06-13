import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/section_title.dart';
import 'package:shipment_merchent_app/features/shipment/screen/tracking_screen.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/bottom_navigation_container.dart';
import 'package:shipment_merchent_app/features/shipment/screen/widgets/summarry_container.dart';
import 'package:sizer/sizer.dart';
import '../../../navigation_menu.dart';
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
      body: WillPopScope(
        onWillPop: () async {
          controller.resetFields();
          Get.to(() => NavigationMenu());
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
                    CustomSizedBox.itemSpacingVertical(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/brcode.png'),
                            height: 10.h,
                          ),
                          CustomSizedBox.itemSpacingHorizontal(),
                          VerticalDivider(
                            color: TColors.black,
                            thickness: 2,
                            width: 2,
                            indent: 1.h,
                            endIndent: 5.h,
                          ),
                          Column(
                            children: [
                              Image(
                                image: AssetImage("assets/images/zebr.png"),
                                height: 5.h,
                                width: 50.w,
                              ),
                              Text(
                                '1589654656654',
                                style: TextStyle(fontSize: 8.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SectionTitle(title: 'ملخص التاجر'),
                    Obx(() =>
                        SummaryContainer(data: traderSummaryData(controller))),
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
                    Get.to(TrackingScreen(shipmentId:31 ));
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

  Map<String, String> traderSummaryData(ShipmentController controller) {
    return {
      'اسم التاجر': controller.merchantInfo.value.name,
      'المحافظة': controller.merchantInfo.value.cityName! ,
      'العنوان': controller.merchantInfo.value.businessName,
      'رقم الهاتف': controller.merchantInfo.value.phone,
    };
  }

  Map<String, String> recipientSummaryData(ShipmentController controller) {
    return {
      'اسم المستلم': controller.recipientName.value,
      'المحافظة': controller.recipientCity.value,
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
      'ملاحظات': controller.shipmentNote.value.isEmpty
          ? '-'
          : controller.shipmentNote.value,
    };
  }
}
