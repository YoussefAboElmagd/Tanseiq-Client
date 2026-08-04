import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class Violation extends StatelessWidget {
  const Violation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
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
        spacing: 10.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('نوع المخالفة', style: TextStyles.font16BlackBold),
              Text('مخالفة مدنية', style: TextStyles.font16SoftBlack),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('وصف المخالفة', style: TextStyles.font16BlackBold),
              Text('مخالفة مدنية', style: TextStyles.font16SoftBlack),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الطرف المتحمل', style: TextStyles.font16BlackBold),
              Text('شركة1', style: TextStyles.font16SoftBlack),
            ],
          ),
        ],
      ),
    );
  }
}
