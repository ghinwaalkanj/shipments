import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_fade/image_fade.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/features/home/controller/home_controller.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final RxInt _currentAdIndex = 0.obs;

    return Obx(() {
      if (controller.ads.isNotEmpty) {
        return Column(
          children: [
            Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: TColors.primary,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.sp),
                child: Obx(() {
                  final imageUrl = controller.ads[_currentAdIndex.value].imageUrl ?? '';
                  return ImageFade(
                    image: CachedNetworkImageProvider(imageUrl),
                    duration: const Duration(milliseconds: 900),
                    syncDuration: const Duration(milliseconds: 150),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    placeholder: Container(
                      color: const Color(0xFFCFCDCA),
                      alignment: Alignment.center,
                      child: const Icon(Icons.photo, color: Colors.white30, size: 128.0),
                    ),
                    loadingBuilder: (context, progress, chunkEvent) =>
                        Center(child: CircularProgressIndicator(value: progress)),
                    errorBuilder: (context, error) => Container(
                      color: const Color(0xFF6F6D6A),
                      alignment: Alignment.center,
                      child: const Icon(Icons.warning, color: Colors.black26, size: 128.0),
                    ),
                  );
                }),
              ),
            ),
            CustomSizedBox.itemSpacingVertical(),
          ],
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }
}
