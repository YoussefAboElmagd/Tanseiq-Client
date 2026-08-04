import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanseiq/core/theming/assets.dart';
import 'package:tanseiq/core/theming/colors.dart';
import 'package:tanseiq/core/theming/styles.dart';

class HypothesisDetailsTitleRow extends StatelessWidget {
  const HypothesisDetailsTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35.w,
          height: 35.h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: ColorsManager.soft2Grey,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            Assets.assetsImagesLocation,
            width: 22.w,
            height: 22.h,
            color: ColorsManager.black,
          ),
        ),
        Text('مخيمات حجاج جنوب اسيا', style: TextStyles.font16BlackBold),
      ],
    );
  }
}
