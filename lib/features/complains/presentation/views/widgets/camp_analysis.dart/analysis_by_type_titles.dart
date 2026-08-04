import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class AnalysisByTypeTitles extends StatelessWidget {
  const AnalysisByTypeTitles({super.key});

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
          Text('علي حسب النوع', style: TextStyles.font14BlackBold),
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
                child: Text('تم الاصلاح', style: TextStyles.font12BlackBold),
              ),
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.orange,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('تم التبليغ', style: TextStyles.font12BlackBold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.mainColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text('عدم اختصاص', style: TextStyles.font12BlackBold),
              ),
              Expanded(
                child: CircleAvatar(
                  radius: 5.r,
                  backgroundColor: ColorsManager.darkRed,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'لم يتم الاصلاح',
                  style: TextStyles.font12BlackBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
