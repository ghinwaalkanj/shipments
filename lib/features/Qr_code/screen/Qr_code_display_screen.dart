import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/utils/constants/paddings.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import '../../../common/widgets/divider_with_text.dart';

class QrCodeDisplayScreen extends StatelessWidget {
  const QrCodeDisplayScreen({Key? key}) : super(key: key);

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
          padding:TPadding.screenPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                const QRCodeDisplay(),
                CustomSizedBox.itemSpacingVertical(),
                const ScanInstructions(),
                CustomSizedBox.itemSpacingVertical(height: 0.7.h),
                const DividerWithText(text: "أو"),
                CustomSizedBox.textSpacingVertical(),
                const DeliveryCodeInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






















class QRCodeDisplay extends StatelessWidget {
  const QRCodeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Image.asset(
          'assets/images/Qr_code.png', // Replace with your QR code image path
          height: 20.h,
          width: 20.h,
        ),
      ),
    );
  }
}

class ScanInstructions extends StatelessWidget {
  const ScanInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
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
          Text(
            'سيبدأ عملية التوصيل للعميل بمجرد مسح المندوب\nرمز ال QR الظاهر لديك.',
            style: CustomTextStyle.greyTextStyle.apply(fontWeightDelta: 0,fontSizeFactor: 0.88),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class DeliveryCodeInput extends StatelessWidget {
  const DeliveryCodeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w),
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
                '#464645666516',
                style: CustomTextStyle.headlineTextStyle.apply(
                  color: TColors.primary,
                  fontSizeFactor:1.1,
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

