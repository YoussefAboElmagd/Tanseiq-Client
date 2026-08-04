import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class AnalysisByStatusTitles extends StatelessWidget {
  const AnalysisByStatusTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.softGrey,
            offset: Offset(0, 5),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        spacing: 10.h,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('علي حسب الحالة', style: TextStyles.font14BlackBold),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.cyan,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('خيام', style: TextStyles.font12BlackBold),
              ),
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.yellow2,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('كهرباء', style: TextStyles.font12BlackBold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.green,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('ارصفة', style: TextStyles.font12BlackBold),
              ),
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.darkRed,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('تكييف', style: TextStyles.font12BlackBold),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.darkBlue,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('مطبخ', style: TextStyles.font12BlackBold),
              ),
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.burbel,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('اسوار', style: TextStyles.font12BlackBold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
