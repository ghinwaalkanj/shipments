import 'package:flutter/material.dart';
import 'package:shipment_merchent_app/common/widgets/custom_shapes/containers/icon_container.dart';
import 'package:sizer/sizer.dart';


class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconContainer(icon: icon),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12.sp,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: SizedBox(
        width: 5.w,
        child: trailing ??
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
      ),
      onTap: onTap,
    );
  }
}

