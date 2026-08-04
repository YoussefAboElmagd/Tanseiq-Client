import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class MapKeys extends StatelessWidget {
  const MapKeys({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.soft3Grey,
            offset: Offset(0, 3),
            blurRadius: 1,
          ),
          BoxShadow(
            color: ColorsManager.soft3Grey,
            offset: Offset(3, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          Text('مفاتيح الخريطة', style: TextStyles.font16BlackBold),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1- كهرباء', style: TextStyles.font14SoftBlackBold),
              Image.asset(
                Assets.assetsImagesTarget,
                color: ColorsManager.red,
                width: 20.w,
              ),
              Text('2- دفاع مدني', style: TextStyles.font14SoftBlackBold),
              Image.asset(
                Assets.assetsImagesTarget,
                color: ColorsManager.yellow,
                width: 20.w,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('3- اخري', style: TextStyles.font14SoftBlackBold),
              Image.asset(
                Assets.assetsImagesTarget,
                color: ColorsManager.darkBlue,
                width: 20.w,
              ),
              Text('4- بنية تحتية', style: TextStyles.font14SoftBlackBold),
              Image.asset(
                Assets.assetsImagesTarget,
                color: ColorsManager.green,
                width: 20.w,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
