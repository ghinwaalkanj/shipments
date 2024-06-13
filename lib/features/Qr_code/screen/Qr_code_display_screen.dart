import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../common/widgets/divider_with_text.dart';

class QrCodeDisplayScreen extends StatelessWidget {
  final String shipmentNumber;

  const QrCodeDisplayScreen({Key? key, required this.shipmentNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: const TAppBar(
        title: 'تسليم الشحنة',
        showBackArrow: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                QRCodeDisplay(shipmentNumber: shipmentNumber),
                CustomSizedBox.itemSpacingVertical(),
                const ScanInstructions(),
                CustomSizedBox.itemSpacingVertical(height: 0.7.h),
                const DividerWithText(text: "أو"),
                CustomSizedBox.textSpacingVertical(),
                DeliveryCodeInput(shipmentNumber: shipmentNumber),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QRCodeDisplay extends StatelessWidget {
  final String shipmentNumber;

  const QRCodeDisplay({Key? key, required this.shipmentNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 25.h,
        width: 25.h,
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: TColors.white,
        ),
        child: QrImageView(
          data: shipmentNumber,
          version: QrVersions.auto,
          size: 20.h,
        ),
      ),
    );
  }
}

class ScanInstructions extends StatelessWidget {
  const ScanInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'امسح الرمز لتسليم الشحنة!',
            style: CustomTextStyle.headlineTextStyle.apply(
              color: TColors.primary,
              fontSizeFactor: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          CustomSizedBox.textSpacingVertical(),
          CustomSizedBox.textSpacingVertical(),
          Text(
            'سيبدأ عملية التوصيل للعميل بمجرد مسح المندوب رمز ال QR الظاهر لديك.',
            style: CustomTextStyle.greyTextStyle
                .apply(fontWeightDelta: 0, fontSizeFactor: 0.88),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class DeliveryCodeInput extends StatelessWidget {
  final String shipmentNumber;

  const DeliveryCodeInput({Key? key, required this.shipmentNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          CustomSizedBox.textSpacingVertical(),
          Container(
            height: 5.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: TColors.white,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Center(
              child: Text(
                '#$shipmentNumber',
                style: CustomTextStyle.headlineTextStyle.apply(
                  color: TColors.primary,
                  fontSizeFactor: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
