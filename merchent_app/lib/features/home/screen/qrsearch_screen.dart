import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/features/home/screen/widgets/qrview.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import '../controller/search_controller.dart';

class BarcodeSearchScreen extends StatelessWidget {
  final SEarchController searchController = Get.put(SEarchController());

  BarcodeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: const TAppBar(
        title: 'بحث الشحنة',
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                if (searchController.qrController != null) {
                  searchController.qrController!.resumeCamera();
                }
              },
              child: Center(
                child: Container(
                  height: 30.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: TColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: QrView(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Center(
              child: Text(
                'امسح الرمز للبحث عن الشحنة !',
                textDirection: TextDirection.rtl,
                style: CustomTextStyle.headlineTextStyle
                    .apply(color: TColors.primary, fontSizeFactor: 1.1),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 1.h),
            Center(
              child: Text(
                'قم بتوجيه الكاميرا نحو رمز QR الخاص \n بالشحنة للبحث عنها.',
                textDirection: TextDirection.rtl,
                style: CustomTextStyle.greyTextStyle.apply(fontSizeFactor: 0.8),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 12.h,),
            Container(
              height: 20.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: TColors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20.sp)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 6.h, horizontal: 5.w),
                child: SingleChildScrollView(
                  child:SizedBox(
                    width: double.infinity,
                    height: 8.h,
                    child: ElevatedButton(
                      onPressed: () {
                        searchController.toggleFlashlight();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Obx(() => Text(
                        searchController.isFlashOn.value ? 'إطفاء الفلاش' : 'تشغيل الفلاش',
                        style: CustomTextStyle.headlineTextStyle
                            .apply(color: TColors.white),
                      )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
