import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/screens/widgets/notification_widgets/notification_tile.dart';
import '../../../controller/tracking_controller.dart';

Widget AnnouncementsTab(TrackingController controller) {
  final announcements = controller.announcements.value;
  return announcements.isEmpty
      ? ListView(
    physics: AlwaysScrollableScrollPhysics(),
    children: [
      SizedBox(height: 5.h),
      Center(
        child: Image(
          image: AssetImage("assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
          height: 20.h,
        ),
      ),
      CustomSizedBox.itemSpacingVertical(height: 0.5.h),
      Center(
        child: Text(
          'لا توجد تبليغات عن الشحنة',
          style: CustomTextStyle.headlineTextStyle,
        ),
      ),
      CustomSizedBox.textSpacingVertical(),
      Center(
        child: Text(
          'حاول لاحقًا لمعرفة ما إذا كان هناك تبليغات عن الشحنة',
          style: CustomTextStyle.headlineTextStyle.apply(color: TColors.darkGrey, fontWeightDelta: -10),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  )
      : Padding(
    padding: EdgeInsets.only(top: 2.h),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          return NotificationTile(
            message: announcement['announcements_text'],
            icon: Icons.warning_amber_outlined,
          );
        },
      ),
    ),
  );
}
