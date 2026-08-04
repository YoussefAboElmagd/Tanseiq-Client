import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/square_number.dart';
import 'package:tanseiq/features/camp/presentation/views/widgets/camp_prepare_and_all_work/tint_area.dart';

class PrepareDetailsAtrributes extends StatelessWidget {
  const PrepareDetailsAtrributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          const TintArea(),
          const SquareNumber(),
          Text('الخدمات:', style: TextStyles.font16MainColorBold),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: campTintPrepareListDetails.length,
              itemBuilder:
                  (context, index) => Container(
                    width: double.infinity,
                    height: 30.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color:
                          index % 2 != 0
                              ? ColorsManager.softGreen
                              : ColorsManager.soft2Grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          campTintPrepareListDetails[index],
                          style: TextStyles.font14BlackBold,
                        ),
                        Text('12', style: TextStyles.font14Grey),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
