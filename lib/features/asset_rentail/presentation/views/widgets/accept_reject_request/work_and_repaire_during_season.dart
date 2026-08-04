import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';

class WorkAndRepairDuringSeason extends StatelessWidget {
  const WorkAndRepairDuringSeason({super.key});

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
        spacing: 20.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الطرف المعني', style: TextStyles.font16Black),
              Text('الشركة1', style: TextStyles.font16SoftBlack),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الوصف', style: TextStyles.font16Black),
              Text('المطور', style: TextStyles.font16SoftBlack),
            ],
          ),
          const Divider(color: ColorsManager.softMainColor),
          Row(
            spacing: 5.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(Assets.assetsImagesPdf, width: 20.w),
              Text('تعهد pdf', style: TextStyles.font14SoftBlack),
              const Spacer(),
              Text(
                DateTime.now().toString().split(' ')[0],
                style: TextStyles.font14Grey,
              ),
            ],
          ),
          Row(
            spacing: 5.w,
            children: [
              Expanded(
                child: CustomButton(
                  color: ColorsManager.green,
                  textStyle: TextStyles.font16WhiteBold,
                  borderRadius: 12.r,
                  title: 'تم الحل',
                  onTap: () {},
                ),
              ),
              Expanded(
                child: CustomButton(
                  color: ColorsManager.darkRed,
                  textStyle: TextStyles.font16WhiteBold,
                  borderRadius: 12.r,
                  title: 'تصعيد',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
