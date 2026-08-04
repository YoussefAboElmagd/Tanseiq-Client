import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ExportAndImportButtonsDesign extends StatelessWidget {
  const ExportAndImportButtonsDesign({
    super.key,
    required this.title,
    required this.image,
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: ColorsManager.softGreen,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 20.w),
          5.width,
          Text(title, style: TextStyles.font16GreenUnderLine),
        ],
      ),
    );
  }
}
