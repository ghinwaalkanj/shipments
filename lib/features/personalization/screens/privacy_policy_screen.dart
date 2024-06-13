import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: 'سياسة الخصوصية',
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
                  'نحن في تطبيق "كويكلي Kwickly" نلتزم بحماية خصوصيتك. تنطبق سياسة الخصوصية هذه على جميع البيانات الشخصية التي نجمعها من خلال التطبيق.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'جمع المعلومات',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'نقوم بجمع المعلومات الشخصية التي تقدمها عند التسجيل في التطبيق أو استخدام خدماتنا. قد تشمل هذه المعلومات الاسم، رقم الهاتف، العنوان، وغيرها من المعلومات اللازمة لتقديم خدمات الشحن.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'استخدام المعلومات',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'نستخدم المعلومات التي نجمعها لتقديم وتحسين خدماتنا. قد نستخدم المعلومات للاتصال بك، وإرسال التحديثات، وتحليل البيانات لفهم كيفية استخدام خدماتنا وتحسينها.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'مشاركة المعلومات',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'لن نقوم ببيع أو تأجير معلوماتك الشخصية لأي طرف ثالث دون موافقتك. قد نقوم بمشاركة المعلومات مع شركائنا ومقدمي الخدمات الذين يساعدوننا في تقديم خدماتنا.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'أمان المعلومات',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'نحن نتخذ التدابير الأمنية اللازمة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو التعديل أو الكشف. على الرغم من ذلك، لا يمكننا ضمان أمان كامل للبيانات المرسلة عبر الإنترنت.',
                  style: CustomTextStyle.greyTextStyle.apply(
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                CustomSizedBox.itemSpacingVertical(height: 1.h),
                Text(
                  'التغييرات على سياسة الخصوصية',
                  style: CustomTextStyle.headlineTextStyle.apply(
                    color: TColors.primary,
                    fontSizeFactor: 1.0,
                    fontWeightDelta: 1,
                  ),
                ),
                CustomSizedBox.textSpacingVertical(),
                Text(
                  'قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سنقوم بإعلامك بأي تغييرات من خلال نشر السياسة الجديدة على التطبيق.',
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
                  'إذا كان لديك أي أسئلة أو مخاوف بشأن سياسة الخصوصية هذه، يرجى الاتصال بنا عبر البريد الإلكتروني: support@kwickly.com.',
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
