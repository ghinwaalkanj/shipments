import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/profile_text_field.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/custom_shapes/containers/common_container.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController businessNameController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TAppBar(
        title: 'المعلومات الشخصية',
        showBackArrow: true,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(
              () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: TColors.primary,))
              : SingleChildScrollView(
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
                    padding: EdgeInsets.symmetric(
                        vertical: 7.h, horizontal: 5.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileTextField(
                            initialValue: controller.profile.value.name,
                            labelText: 'الاسم بالكامل',
                          ),
                          CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                          ProfileTextField(
                            initialValue: controller.profile.value.phone,
                            labelText: 'رقم الهاتف',
                          ),
                          CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                          ProfileTextField(
                            initialValue: controller.profile.value.businessName,
                            labelText: 'النشاط التجاري',
                          ),
                          CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                          TButton(
                            text: 'تأكيد',
                            onPressed: () {

                            },
                          ),
                          TTextButton(text: 'تسجيل خروج', onPressed: () {})
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
