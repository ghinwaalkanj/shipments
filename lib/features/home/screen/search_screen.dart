import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:shipment_merchent_app/features/home/screen/qrsearch_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/serch_text_field.dart';
import '../../../utils/constants/colors.dart';
import '../../shipment/screen/tracking_screen.dart';
import '../controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SEarchController controller = Get.put(SEarchController());
    final FocusNode focusNode = FocusNode();
    final TextEditingController searchController = TextEditingController();

    // Set the focus on the search field after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'نتائج البحث',
        showBackArrow: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    TSearchFormField(
                      iscearch: true,
                      hintText: 'ابحث عن الشحنة',
                      controller: searchController,
                      focusNode: focusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.searchShipment(value);
                        }
                      },
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CircularContainer(
                      onTap: (){
                        Get.to(BarcodeSearchScreen());
                      },
                      icon: Icons.qr_code_scanner,
                      color: TColors.primary,
                    ),
                  ],
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Container(
                        height: 50.h,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (controller.searchResult.value == null) {
                    return Column(
                      children: [
                        Center(
                          child: Image(
                            image: AssetImage(
                                "assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
                          ),
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                        Text(
                          'لا توجد شحنة',
                          style: CustomTextStyle.headlineTextStyle,
                        ),
                        CustomSizedBox.textSpacingVertical(),
                        Text(
                          'حاول البحث عن شحنة أخرى',
                          style: CustomTextStyle.headlineTextStyle.apply(
                              color: TColors.darkGrey, fontWeightDelta: -1),
                        ),
                      ],
                    );
                  } else {
                    final shipment =
                        controller.searchResult.value!.shipmentInfo;
                    final userInfo = controller.searchResult.value!.userInfo;
                    final recipientInfo =
                        controller.searchResult.value!.recipientInfo;

                    return ListView.builder(
                      padding: EdgeInsets.all(2.w),
                      itemCount: 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(TrackingScreen(shipmentId: shipment.shipmentId));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.w),
                            child: Container(
                              padding: EdgeInsets.only(right: 5.w),
                              height: 19.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.sp),
                                color: TColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: TColors.black.withOpacity(0.25),
                                    blurRadius: 8,
                                    spreadRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 15.h,
                                    width: 15.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.sp),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            shipment.shipmentType == "سريع"
                                                ? "assets/images/fast.png"
                                                : "assets/images/normal.png"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(top: 2.h, right: 6.w),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            shipment.shipmentContents,
                                            style: CustomTextStyle
                                                .headlineTextStyle
                                                .apply(
                                                fontSizeFactor: 0.7,
                                                fontWeightDelta: 2),
                                          ),
                                        ),
                                        Text(
                                          '#${shipment.shipmentNumber}',
                                          style: CustomTextStyle.greyTextStyle,
                                        ),
                                        CustomSizedBox.textSpacingVertical(),
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/Subtract (1).png'),
                                              height: 5.h,
                                              width: 5.w,
                                            ),
                                            SizedBox(width: 2.w),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userInfo.city,
                                                  style: CustomTextStyle
                                                      .headlineTextStyle
                                                      .apply(fontSizeFactor: 0.6),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 0.1.h,
                                          padding: EdgeInsets.only(right: 0.3.w),
                                          child: Transform.scale(
                                            scaleY: 15,
                                            child: VerticalDivider(
                                              thickness: 0.5.w,
                                              color: TColors.black,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/Subtract (2).png'),
                                              height: 5.h,
                                              width: 5.w,
                                            ),
                                            SizedBox(width: 2.w),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  recipientInfo.city == null
                                                      ? 'جاري التحميل ...'
                                                      : recipientInfo.city,
                                                  style: CustomTextStyle
                                                      .headlineTextStyle
                                                      .apply(fontSizeFactor: 0.6),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
