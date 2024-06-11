import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_field.dart';
import 'package:shipment_merchent_app/features/auth/screen/id_upload_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/text_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../common/widgets/button.dart';
import '../controller/personal_info_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInfoController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10.h,
            left: 6.w,
            right: 6.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 6.5.h),
              Text(
                'المعلومات الشخصية',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                'مرحبا! قبل البدء، يُرجى إدخال معلوماتك الشخصية\nلتوثيق هويتك والوصول إلى خدماتنا بسهولة',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: TColors.darkGrey,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 7.h),
              TTextField(
                hintText: "الاسم الكامل",
                prefixIcon: Icon(Icons.person_3_outlined),
                controller: controller.fullNameController,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  controller.fullName.value = value;
                  controller.validateForm();
                },
              ),
              SizedBox(height: 2.h),
              TTextField(
                hintText: "الرقم الوطني",
                prefixIcon: Icon(Icons.date_range),
                controller: controller.idController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.nationalId.value = value;
                  controller.validateForm();
                },
              ),
              SizedBox(height: 2.h),
              TTextField(
                hintText: "اسم نشاطك التجاري",
                prefixIcon: Icon(Iconsax.bag_24),
                controller: controller.shopController,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.businessName.value = value;
                  controller.validateForm();
                },
              ),
              SizedBox(height: 2.h),
              Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButtonFormField<String>(
                  value: controller.gender.value.isEmpty
                      ? null
                      : controller.gender.value,
                  items: ['ذكر', 'أنثى']
                      .map((label) => DropdownMenuItem(
                            child: Text(
                              label,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: TColors.darkGrey,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.gender.value = value!;
                    controller.validateForm();
                  },
                  decoration: InputDecoration(
                    hintText: 'النوع',
                    hintStyle: TextStyle(
                      fontSize: 9.sp,
                      color: TColors.darkGrey,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                    ),
                    prefixIcon: IconTheme(
                      data: IconThemeData(
                        color: TColors.primary, // Change the color
                        size: 24.sp, // Change the size
                      ),
                      child: Icon(Icons.male),
                    ),
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: TColors.primary, width: 2.0),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down,
                      textDirection: TextDirection.ltr),
                ),
              ),
              SizedBox(height: 7.h),
              Obx(() => TButton(
                    text: controller.isLoading.value
                        ? 'جاري التحميل...'
                        : 'متابعة',
                    onPressed: controller.submitPersonalInfo,
                  )),
              CustomSizedBox.itemSpacingVertical(),
              Align(
                alignment: Alignment.center,
                child: TTextButton(
                  text: 'رجوع',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
