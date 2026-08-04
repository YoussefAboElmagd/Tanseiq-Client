import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class ReportsDetailsItem extends StatelessWidget {
  const ReportsDetailsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.soft2Grey,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsManager.mainColor),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مشكله بكهرباء مخيم B12',
                style: TextStyles.font16SoftBlackBold,
              ),
              Text('11.30 AM', style: TextStyles.font16Grey),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz_outlined,
              color: ColorsManager.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
