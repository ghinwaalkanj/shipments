import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/features/shipment/screen/shipment1_screen.dart';
import 'package:shipment_merchent_app/features/Qr_code/screen/Qr_code_scan.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/curved_rectangular_container.dart';

import '../../../../common/styles/custom_textstyle.dart';
import '../../../../common/widgets/custom_sized_box.dart';
import '../../controller/home_controller.dart';

class ServiceWidgets extends StatelessWidget {
  const ServiceWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedBox.itemSpacingVertical(),
        Padding(
          padding:  EdgeInsets.only(right:2.w),
          child: Text(
            'خدماتنا',
            style: CustomTextStyle.headlineTextStyle,
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CurvedRectangular(
              onTap: () {
                if (controller.addressDetails.value.isEmpty) {
                  Get.snackbar(
                    'خطأ',
                    'يرجى تعيين عنوان افتراضي قبل إضافة شحنة جديدة',
                    backgroundColor: TColors.primary,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP,
                    margin: EdgeInsets.all(10),
                    borderRadius: 10,
                    icon: Icon(Icons.check_circle_outline, color: Colors.white),
                    duration: Duration(seconds: 5),
                  );
                } else {
                  Get.to(ShipmentStep1Screen());
                }
              },
              height: 6.h,
              color: Color(0xffC1D7C0),
              text: 'إضافة شحنة',
              image: 'assets/images/truck.png',
              textColor: Color(0xff37972B),
            ),
            CurvedRectangular(
              onTap: () {
                Get.to(BarcodeScanScreen(
                  onBarcodeScanned: (barcode) async {
                     await controller.receiveShipmentBack(barcode);
                  },
                ));
              },
              height: 6.h,
              color: Color(0xffC0D5D8),
              text: 'إستلام راجع',
              image: 'assets/images/qr_code2.png',
              textColor: Color(0xff14818E),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
