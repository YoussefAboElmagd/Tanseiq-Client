import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class UploadFileButtonDesign extends StatelessWidget {
  const UploadFileButtonDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 35.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorsManager.softGreen,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Image.asset(Assets.assetsImagesExport, width: 15.w),
          5.width,
          Text('تحميل ملف', style: TextStyles.font14GreenUnderLine),
        ],
      ),
    );
  }
}
