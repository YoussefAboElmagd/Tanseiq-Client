import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampDetailsTintPrepareItemDesign extends StatelessWidget {
  const CampDetailsTintPrepareItemDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('الفئة 1', style: TextStyles.font16BlackBold),
              const Spacer(),
              Container(
                height: 26.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: ColorsManager.mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Image.asset(Assets.assetsImagesCorrect, width: 12.w),
                    5.width,
                    Text('جاري العمل', style: TextStyles.font10WhiteBold),
                  ],
                ),
              ),
            ],
          ),
          10.height,
          const Divider(color: ColorsManager.softGrey),
          10.height,
          Row(
            children: [
              Text('خيمة رقم 4-4', style: TextStyles.font14Black),
              const Spacer(),
              Text('123متر', style: TextStyles.font14Black),
            ],
          ),
        ],
      ),
    );
  }
}
