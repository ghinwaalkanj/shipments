import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        ),
        child: Row(
          children: [
            SizedBox(width: 2.w,),
            Icon(
              icon,
              color: TColors.darkerGrey,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              text,
              style: TextStyle(
                color: TColors.darkGrey,
                fontFamily: 'Cairo',
              )
            ),
          ],
        ),
      ),
    );
  }
}
