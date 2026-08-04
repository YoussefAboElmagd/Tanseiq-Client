import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class PdfButtonDesign extends StatelessWidget {
  const PdfButtonDesign({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: ColorsManager.soft2MainColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsManager.mainColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.w,
        children: [
          Text(title, style: TextStyles.font14SoftBlackBold),
          Image.asset(Assets.assetsImagesPdf, width: 25.w),
        ],
      ),
    );
  }
}
