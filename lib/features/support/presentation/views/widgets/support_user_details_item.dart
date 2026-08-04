import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class SupportUserDetailItem extends StatelessWidget {
  const SupportUserDetailItem({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      width: double.infinity,
      height: 45.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsManager.mainColor, width: 1.w),
      ),
      child: Text(data, style: TextStyles.font14Black),
    );
  }
}
