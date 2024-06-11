import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/common/widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../common/widgets/serch_text_field.dart';
import '../../../utils/constants/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      hintText: 'ابحث عن الشحنة',
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CircularContainer(
                      icon: Icons.qr_code_scanner,
                      color: TColors.primary,
                    ),
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(height: 0.5.h),
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
                  style: CustomTextStyle.headlineTextStyle
                      .apply(color: TColors.darkGrey, fontWeightDelta: -1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
