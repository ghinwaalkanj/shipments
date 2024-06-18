import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/screens/widgets/section_title.dart';
import '../../../controller/tracking_controller.dart';
import '../add_shipment_widgets/summarry_container.dart';

Widget ElectronicReceiptTab(TrackingController controller) {
  final shipmentInfo = controller.shipmentInfo.value;
  if (shipmentInfo.isEmpty) {
    return Center(
      child: Text('No shipment info available.'),
    );
  }
  return Padding(
    padding: EdgeInsets.only(top: 1.h),
    child: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 2.h,),
          Center(
            child: Container(
              height: 15.h,
              width: 80.w,
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
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: QrImageView(
                        data: '${shipmentInfo['shipment_number']}',
                        version: QrVersions.auto,
                        size: 20.h,
                      ),
                      height: 15.h,
                      width: 25.w,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                    VerticalDivider(
                      color: TColors.black.withOpacity(0.5),
                      thickness: 2,
                      width: 2,
                      indent: 1.h,
                      endIndent: 2.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/zebr.png"),
                          height: 5.h,
                          width: 45.w,
                        ),
                        Text('${shipmentInfo['shipment_number']}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SectionTitle(title: 'ملخص التاجر'),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SummaryContainer(data: traderSummaryData(controller)),
          ),
          const SectionTitle(title: 'ملخص المستلم'),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SummaryContainer(data: recipientSummaryData(controller)),
          ),
          const SectionTitle(title: 'ملخص الشحنة'),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SummaryContainer(data: shipmentSummaryData(controller)),
          ),
        ],
      ),
    ),
  );
}

Map<String, String> traderSummaryData(TrackingController controller) {
  final merchantInfo = controller.merchantInfo.value;
  return {
    'اسم التاجر': merchantInfo['name'] ?? '',
    'المحافظة': merchantInfo['city'] ?? '',
    'العنوان': merchantInfo['from_address_details'] ?? '',
    'النشاط التجاري': merchantInfo['business_name'] ?? '',
  };
}

Map<String, String> recipientSummaryData(TrackingController controller) {
  final recipientInfo = controller.recipientInfo.value;
  return {
    'اسم المستلم': recipientInfo['name'] ?? '',
    'المحافظة': recipientInfo['city'] ?? '',
    'العنوان': recipientInfo['address'] ?? '',
    'رقم الهاتف': recipientInfo['phone'] ?? '',
  };
}

Map<String, String> shipmentSummaryData(TrackingController controller) {
  final shipmentInfo = controller.shipmentInfo.value;
  return {
    'محتوى الشحنة': shipmentInfo['shipment_contents'] ?? '',
    'سرعة الشحن': shipmentInfo['shipment_type'] ?? '',
    'الوزن': '${shipmentInfo['shipment_weight'] ?? 0} كغ',
    'العدد': '${shipmentInfo['shipment_quantity'] ?? 0} قطعة',
    'السعر': '${shipmentInfo['shipment_value'] ?? 0} JD',
    'تكاليف الشحن': '${shipmentInfo['shipment_fee'] ?? 0} JD',
    'ملاحظات': shipmentInfo['shipment_note']?.isEmpty ?? true ? '-' : shipmentInfo['shipment_note'] ?? '',
  };
}
