import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/privacy_policy_widgets/section_content.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/terms_and_conditions_widgets/terms_section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'widgets/section_title.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

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
              children:  [
                TermsSectionTitle(title: 'مقدمة'),
                SectionContent(content: 'نحن في تطبيق "كويكلي Kwickly" نلتزم بحماية خصوصيتك. تنطبق سياسة الخصوصية هذه على جميع البيانات الشخصية التي نجمعها من خلال التطبيق.'),
                TermsSectionTitle(title: 'جمع المعلومات'),
                SectionContent(content: 'نقوم بجمع المعلومات الشخصية التي تقدمها عند التسجيل في التطبيق أو استخدام خدماتنا. قد تشمل هذه المعلومات الاسم، رقم الهاتف، العنوان، وغيرها من المعلومات اللازمة لتقديم خدمات الشحن.'),
                TermsSectionTitle(title: 'استخدام المعلومات'),
                SectionContent(content: 'نستخدم المعلومات التي نجمعها لتقديم وتحسين خدماتنا. قد نستخدم المعلومات للاتصال بك، وإرسال التحديثات، وتحليل البيانات لفهم كيفية استخدام خدماتنا وتحسينها.'),
                TermsSectionTitle(title: 'مشاركة المعلومات'),
                SectionContent(content: 'لن نقوم ببيع أو تأجير معلوماتك الشخصية لأي طرف ثالث دون موافقتك. قد نقوم بمشاركة المعلومات مع شركائنا ومقدمي الخدمات الذين يساعدوننا في تقديم خدماتنا.'),
                TermsSectionTitle(title: 'أمان المعلومات'),
                SectionContent(content: 'نحن نتخذ التدابير الأمنية اللازمة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو التعديل أو الكشف. على الرغم من ذلك، لا يمكننا ضمان أمان كامل للبيانات المرسلة عبر الإنترنت.'),
                TermsSectionTitle(title: 'التغييرات على سياسة الخصوصية'),
                SectionContent(content: 'قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سنقوم بإعلامك بأي تغييرات من خلال نشر السياسة الجديدة على التطبيق.'),
                TermsSectionTitle(title: 'الاتصال بنا'),
                SectionContent(content: 'إذا كان لديك أي أسئلة أو مخاوف بشأن سياسة الخصوصية هذه، يرجى الاتصال بنا عبر البريد الإلكتروني: support@kwickly.com.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
