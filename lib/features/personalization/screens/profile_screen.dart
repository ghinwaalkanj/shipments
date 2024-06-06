import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:shipment_merchent_app/features/personalization/screens/settings_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/profile_text_field.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/utils/constants/paddings.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/custom_shapes/containers/common_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TAppBar(
        title: 'المعلومات الشخصية',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomSizedBox.itemSpacingVertical(),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50.sp,
                      backgroundColor: TColors.white,
                      child: Icon(
                        Iconsax.user,
                        size: 50.sp,
                        color: TColors.primary,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 2.w,
                      child: CircleAvatar(
                        radius: 12.sp,
                        backgroundColor: TColors.primary,
                        child: Icon(Iconsax.edit,
                            color: Colors.white, size: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizedBox.itemSpacingVertical(),
              CommonContainer(
                height: 70.h,
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ProfileTextField(
                          initialValue: 'محمود ناصر العلي',
                          labelText: 'الاسم بالكامل',
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                        ProfileTextField(
                          initialValue: '+963 9--- --- ---',
                          labelText: 'رقم الهاتف',
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                        ProfileTextField(
                          initialValue: 'تجارة المتة بالجملة',
                          labelText: 'النشاط التجاري',
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                        TButton(
                          text: 'تأكيد',
                          onPressed: () {},
                        ),
                        TTextButton(text: 'تسجيل خروج',onPressed: (){})
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
