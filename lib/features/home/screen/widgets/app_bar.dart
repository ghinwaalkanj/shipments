import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shipment_merchent_app/common/styles/custom_textstyle.dart';
import 'package:shipment_merchent_app/utils/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.onTap,
  }) : super(key: key);

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 17.h,
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.h),
                  child: title),
              actions: actions != null
                  ? actions!
                      .map((action) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            // Adjust padding as needed
                            child: action,
                          ))
                      .toList()
                  : null,
              elevation: 0,
            ),
            Positioned(
              bottom: 1.8.h,
              right: 7.w,
              child: Row(
                children: [
                  Text(
                    "دمشق - زاهرة جديدة",
                    style: CustomTextStyle.headlineTextStyle,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_arrow_down_rounded))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(25.h);
}
