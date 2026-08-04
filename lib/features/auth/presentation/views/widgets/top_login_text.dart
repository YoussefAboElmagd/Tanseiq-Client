import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class TopLoginText extends StatelessWidget {
  const TopLoginText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorsManager.mainColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Text(title, style: TextStyles.font20WhiteBold),
    );
  }
}
