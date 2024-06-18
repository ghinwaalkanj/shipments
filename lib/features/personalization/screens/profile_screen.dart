import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:shipment_merchent_app/features/auth/screen/login_screen.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/profile_text_field.dart';
import 'package:shipment_merchent_app/features/personalization/screens/widgets/traderRanking_widget.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/custom_shapes/containers/common_container.dart';
import '../../../core/services/storage_service.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

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
              ? Center(child: CircularProgressIndicator(color: TColors.primary))
              : SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSizedBox.itemSpacingVertical(),
                    TraderRankingWidget(
                      rankingPercentage: controller.merchant_rank.toDouble(),
                      totalShipments: controller.totalShipments.value,
                      motivationalMessage: 'كن الملك في Kwickly واعمل المزيد من الشحنات!',
                    ),
                    CustomSizedBox.itemSpacingVertical(),
                    CommonContainer(
                      height: 70.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 5.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ProfileTextField(
                                labelText: 'الاسم بالكامل',
                                controller: controller.nameController,
                              ),
                              CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                              ProfileTextField(
                                labelText: 'رقم الهاتف',
                                controller: controller.phoneController,
                              ),
                              CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                              ProfileTextField(
                                labelText: 'النشاط التجاري',
                                controller: controller.businessNameController,
                              ),
                              CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                              TButton(
                                text: 'حفظ',
                                onPressed: () {
                                  controller.editProfile(
                                    controller.nameController.text,
                                    controller.phoneController.text,
                                    controller.businessNameController.text,
                                  );
                                },
                              ),
                              TTextButton(
                                text: 'تسجيل خروج',
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text(
                                            'تأكيد تسجيل الخروج',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: TColors.primary,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                          content: Text(
                                            'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: TColors.darkGrey,
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                'إلغاء',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: TColors.primary,
                                                  fontFamily: 'Cairo',
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'تسجيل خروج',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.red,
                                                  fontFamily: 'Cairo',
                                                ),
                                              ),
                                              onPressed: () async {
                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                prefs.remove("isAuth");
                                                FirebaseMessaging.instance.unsubscribeFromTopic("merchant");
                                                FirebaseMessaging.instance
                                                    .unsubscribeFromTopic("merchant${prefs.getInt('user_id').toString()}");
                                                Get.offAll(LoginScreen());
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

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
