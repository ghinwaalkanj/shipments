import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/button.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/widgets/text_button.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/id_upload_controller.dart';

class IDUploadScreen extends StatelessWidget {
  final IDUploadController controller = Get.put(IDUploadController());

  IDUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      controller.setInitialImages(
        arguments['id_front_image'],
        arguments['id_back_image'],
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 6.5.h,
          left: 6.w,
          right: 6.w,
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'أضف صورة البطاقة الشخصية',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: TColors.primary,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              'تأكد من ظهور صورة الوجه الأمامي والخلفي للبطاقة بشكل واضح وصحيح.',
              style: TextStyle(
                fontSize: 10.sp,
                color: TColors.darkGrey,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () => controller.pickImage(true),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/Subtract.png",
                    height: 20.h,
                  ),
                  Obx(() {
                    if (controller.idFrontImage.value.path.isEmpty) {
                      if (controller.idFrontImageUrl.value.isEmpty) {
                        return Image.asset(
                          "assets/images/front_id.png",
                          height: 15.h,
                          opacity: AlwaysStoppedAnimation(0.5),
                        );
                      } else {
                        return Image.network(
                          'https://api.wasenahon.com/Kwickly/upload/id_images/${controller.idFrontImageUrl.value}',
                          height: 15.h,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: TColors.primary,
                                value: loadingProgress.expectedTotalBytes !=
                                    null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ??
                                        1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/front_id.png",
                                  height: 10.h,
                                  opacity: AlwaysStoppedAnimation(0.5),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  'تعذر تحميل الصورة',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: TColors.darkGrey,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                          opacity: AlwaysStoppedAnimation(0.5),
                        );
                      }
                    } else {
                      return Image.file(
                        controller.idFrontImage.value,
                        height: 15.h,
                      );
                    }
                  }),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () => controller.pickImage(false),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/Subtract.png",
                    height: 20.h,
                  ),
                  Obx(() {
                    if (controller.idBackImage.value.path.isEmpty) {
                      if (controller.idBackImageUrl.value.isEmpty) {
                        return Image.asset(
                          "assets/images/back_id.png",
                          height: 15.h,
                          opacity: AlwaysStoppedAnimation(0.5),
                        );
                      } else {
                        return Image.network(
                          'https://api.wasenahon.com/Kwickly/upload/id_images/${controller.idBackImageUrl.value}',
                          height: 15.h,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: TColors.primary,
                                value: loadingProgress.expectedTotalBytes !=
                                    null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ??
                                        1)
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/back_id.png",
                                  height: 10.h,
                                  opacity: AlwaysStoppedAnimation(0.5),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  'تعذر تحميل الصورة',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: TColors.darkGrey,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          },
                          opacity: AlwaysStoppedAnimation(0.5),
                        );
                      }
                    } else {
                      return Image.file(
                        controller.idBackImage.value,
                        height: 15.h,
                      );
                    }
                  }),
                ],
              ),
            ),
            Spacer(),
            Obx(
                  () => TButton(
                text: controller.isLoading.value ? 'جاري التحميل...' : 'متابعة',
                onPressed: () {
                  controller.uploadIDImages();
                },
              ),
            ),
            CustomSizedBox.itemSpacingVertical(),
            TTextButton(
              text: 'رجوع',
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(height: 6.5.h),
          ],
        ),
      ),
    );
  }
}
