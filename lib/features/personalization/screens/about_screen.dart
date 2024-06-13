import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: 'حول التطبيق',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png', // تأكد من وجود الصورة في مجلد assets
                    height: 20.h,
                    width: 20.h,
                  ),
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'حول التطبيق',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.2,
                    fontWeightDelta: 2,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'تطبيق Kwickly يوفر لك أفضل تجربة لإدارة الشحنات بسهولة وسرعة. يمكنك تتبع شحناتك في أي وقت وفي أي مكان. نحن ملتزمون بتقديم أفضل خدمة لعملائنا.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'مزايا التطبيق',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.2,
                    fontWeightDelta: 2,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  '- تتبع الشحنات بسهولة.\n'
                      '- إشعارات فورية لتحديثات الشحن.\n'
                      '- واجهة مستخدم بسيطة وسهلة الاستخدام.\n'
                      '- دعم فني على مدار الساعة.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
