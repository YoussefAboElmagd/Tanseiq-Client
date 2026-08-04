import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/hijri_date_validator.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class AccessRestrictedWidget extends StatelessWidget {
  const AccessRestrictedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.h,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: const BoxDecoration(
                color: ColorsManager.softRed,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                color: ColorsManager.red,
                size: 32.r,
              ),
            ),
            Text('النموذج مغلق حالياً', style: TextStyles.font18BlackBold),
            SizedBox(
              width: 60.w,
              child: const Divider(color: ColorsManager.soft3Grey),
            ),
            Column(
              spacing: 8.h,
              children: HijriDateValidator.allowedPeriods.map((p) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.soft5Grey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(p.label, style: TextStyles.font14NormalGrey),
                      Text(
                        '${p.day} ذو القعدة',
                        style: TextStyles.font14BlackBold,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorsManager.softRed,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text('مغلق', style: TextStyles.font14RedBold),
            ),
          ],
        ),
      ),
    );
  }
}
