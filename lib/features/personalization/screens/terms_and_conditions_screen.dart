import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/terms_and_conditions_widgets/terms_section_content.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/terms_and_conditions_widgets/terms_section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

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
              children: const [
                TermsSectionTitle(title: 'مقدمة'),
                TermsSectionContent(content: 'مرحباً بكم في تطبيق "كويكلي Kwickly". باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بالشروط والأحكام التالية.'),
                TermsSectionTitle(title: 'استخدام التطبيق'),
                TermsSectionContent(content: 'يتعين عليك استخدام هذا التطبيق بطريقة قانونية ومناسبة وفقاً لجميع القوانين واللوائح المعمول بها.'),
                TermsSectionTitle(title: 'حقوق الملكية الفكرية'),
                TermsSectionContent(content: 'جميع الحقوق المتعلقة بالمحتوى والبرمجيات والتكنولوجيا المستخدمة في هذا التطبيق مملوكة لشركة "كويكلي Kwickly" أو مرخصيها.'),
                TermsSectionTitle(title: 'المسؤولية'),
                TermsSectionContent(content: 'نحن غير مسؤولين عن أي خسائر أو أضرار تنشأ عن استخدامك لهذا التطبيق.'),
                TermsSectionTitle(title: 'التعديلات على الأحكام والشروط'),
                TermsSectionContent(content: 'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. سيتم إشعارك بأي تغييرات عن طريق نشر الشروط الجديدة على التطبيق.'),
                TermsSectionTitle(title: 'الاتصال بنا'),
                TermsSectionContent(content: 'إذا كان لديك أي أسئلة أو استفسارات حول هذه الأحكام والشروط، يرجى الاتصال بنا عبر البريد الإلكتروني: support@kwickly.com.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
