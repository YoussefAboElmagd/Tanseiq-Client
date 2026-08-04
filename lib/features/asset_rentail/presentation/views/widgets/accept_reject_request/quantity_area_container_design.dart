import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class QuantityAreaContainerDesign extends StatelessWidget {
  const QuantityAreaContainerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
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
        spacing: 20.h,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الفئة', style: TextStyles.font16Black),
              Text('12x12', style: TextStyles.font16SoftBlack),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('العدد', style: TextStyles.font16Black),
              Text('123', style: TextStyles.font16GreenBold),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('المساحة', style: TextStyles.font16Black),
              Text('123 منر', style: TextStyles.font16GreenBold),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الاجمالي', style: TextStyles.font16Black),
              Text('123 منر', style: TextStyles.font16SoftBlack),
            ],
          ),
        ],
      ),
    );
  }
}
