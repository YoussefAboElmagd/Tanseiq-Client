import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/helpers/extentions.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';
import 'package:tanseiq/core/widgets/custom_button.dart';

class AddAndPreparingButtons extends StatelessWidget {
  const AddAndPreparingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        spacing: 10.h,
        children: [
          20.height,
          CustomButton(
            textStyle: TextStyles.font16WhiteBold,
            title: 'رخصة الجاهزية',
            onTap: () {},
          ),
          CustomButton(
            textStyle: TextStyles.font16WhiteBold,
            title: 'طلب الاضافة',
            color: ColorsManager.green,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
