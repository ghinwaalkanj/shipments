import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/api_constants.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';

import '../../../controller/id_upload_controller.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IDUploadController controller = Get.find();

    return Stack(
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
                '${UploadIdImagesAPI}${controller.idFrontImageUrl.value}',
                height: 15.h,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: TColors.primary,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
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
    );
  }
}
