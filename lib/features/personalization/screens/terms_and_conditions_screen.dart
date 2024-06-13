import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: 'الأحكام والشروط',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.textSpacingVertical(height: 0.5.h),
                Text(
                  'مقدمة',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'مرحباً بكم في تطبيق "كويكلي Kwickly". باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بالشروط والأحكام التالية.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'استخدام التطبيق',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'يتعين عليك استخدام هذا التطبيق بطريقة قانونية ومناسبة وفقاً لجميع القوانين واللوائح المعمول بها.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'حقوق الملكية الفكرية',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'جميع الحقوق المتعلقة بالمحتوى والبرمجيات والتكنولوجيا المستخدمة في هذا التطبيق مملوكة لشركة "كويكلي Kwickly" أو مرخصيها.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'المسؤولية',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'نحن غير مسؤولين عن أي خسائر أو أضرار تنشأ عن استخدامك لهذا التطبيق.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'التعديلات على الأحكام والشروط',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. سيتم إشعارك بأي تغييرات عن طريق نشر الشروط الجديدة على التطبيق.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'الاتصال بنا',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'إذا كان لديك أي أسئلة أو استفسارات حول هذه الأحكام والشروط، يرجى الاتصال بنا عبر البريد الإلكتروني: support@kwickly.com.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.textSpacingVertical(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
