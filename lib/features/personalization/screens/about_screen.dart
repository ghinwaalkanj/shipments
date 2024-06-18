import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/about_widgets/section_content.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/about_widgets/section_logo.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/about_widgets/section_title.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

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
              children: const [
                AboutSectionLogo(),
                AboutSectionTitle(title: 'حول التطبيق'),
                AboutSectionContent(content: 'تطبيق Kwickly يوفر لك أفضل تجربة لإدارة الشحنات بسهولة وسرعة. يمكنك تتبع شحناتك في أي وقت وفي أي مكان. نحن ملتزمون بتقديم أفضل خدمة لعملائنا.'),
                AboutSectionTitle(title: 'مزايا التطبيق'),
                AboutSectionContent(content: '- تتبع الشحنات بسهولة.\n- إشعارات فورية لتحديثات الشحن.\n- واجهة مستخدم بسيطة وسهلة الاستخدام.\n- دعم فني على مدار الساعة.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
