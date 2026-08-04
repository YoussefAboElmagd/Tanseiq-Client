import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class CampNumberItemDesign extends StatelessWidget {
  const CampNumberItemDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h),
      // height: 160.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.soft3Grey,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: ColorsManager.mainColor, width: 1.w),
      ),
      child: Column(
        spacing: 10.h,
        children: [
          Row(
            children: [
              Text('رقم الطلب:', style: TextStyles.font14MainColorBold),
              Text('123', style: TextStyles.font14BlackBold),
              const Spacer(),
              Container(
                width: 80.w,
                height: 26.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorsManager.mainColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text('عرفات', style: TextStyles.font12WhiteBold),
              ),
            ],
          ),
          const Divider(color: ColorsManager.soft2MainColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الشركة المؤجرة', style: TextStyles.font14SoftBlack),
              Text('الشركة 1', style: TextStyles.font14SoftBlack),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الشركة المطورة', style: TextStyles.font14SoftBlack),
              Text('الشركة 1', style: TextStyles.font14SoftBlack),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('رقم المربع 4-4', style: TextStyles.font14SoftBlack),
              Text('313 حاج', style: TextStyles.font14SoftBlack),
            ],
          ),
          const Divider(color: ColorsManager.soft2MainColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الجنسية جنوب اسيا', style: TextStyles.font14Grey),
              Text(
                DateTime.now().toString().split(' ').first,
                style: TextStyles.font14Grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
