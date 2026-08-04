import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';

class HomeItemDesign extends StatelessWidget {
  const HomeItemDesign({
    super.key,
    required this.onTap,
    required this.widget,
    this.height,
  });
  final Function() onTap;
  final Widget widget;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 270.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: const [
            BoxShadow(
              color: ColorsManager.softGrey,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: ColorsManager.mainColor),
        ),
        child: widget,
      ),
    );
  }
}
