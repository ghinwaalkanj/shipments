import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15.h,
      left: 20.w,
      child: Image(
        height: 15.h,
        image: AssetImage(
          "assets/images/logo.png",
        ),
      ),
    );
  }
}
