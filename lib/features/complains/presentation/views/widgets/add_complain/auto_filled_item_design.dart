import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';

class AutoFilledItemDesign extends StatelessWidget {
  const AutoFilledItemDesign({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: ColorsManager.softGreen,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsManager.green),
      ),
      child: child,
    );
  }
}
