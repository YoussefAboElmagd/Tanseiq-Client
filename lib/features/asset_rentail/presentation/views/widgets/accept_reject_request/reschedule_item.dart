import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';

class RescheduleItem extends StatelessWidget {
  const RescheduleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(bottom: 10.h),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الطرف المعني', style: TextStyles.font16BlackBold),
              Text('الشركة 1', style: TextStyles.font16SoftBlack),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الوصف', style: TextStyles.font16BlackBold),
              Text('المطور', style: TextStyles.font16SoftBlack),
            ],
          ),
          Row(
            spacing: 10.w,
            children: [
              Image.asset(Assets.assetsImagesPdf, width: 25.w),
              Text('تعهد pdf', style: TextStyles.font14MainColorBold),
              const Spacer(),
              Text(
                DateTime.now().toString().split(' ')[0],
                style: TextStyles.font14Grey,
              ),
            ],
          ),
          20.height,
          Row(
            spacing: 10.w,
            children: [
              Expanded(
                child: CustomButton(
                  textStyle: TextStyles.font16WhiteBold,
                  color: ColorsManager.green,
                  title: 'مكتمل',
                  onTap: () {},
                ),
              ),
              Expanded(
                child: CustomButton(
                  textStyle: TextStyles.font16WhiteBold,
                  color: ColorsManager.mainColor,
                  title: 'اعادة جدولة',
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
